class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  has_many :payments
  has_many :retreat_registrations

  validates_format_of :phone, :with => /\d*[1-9]\d*/i, :on => :update, message: "This isn't a valid number!", :allow_blank => true

  def fullname
    self.fname ? self.fname + " " + self.lname : nil
  end

  def address
    self.line1 + self.city + self.state + self.zip
  end

  def new_card(stripe_token)
    begin
      raise "No stripe token submitted" unless stripe_token
      if self.stripe_id
        customer = Stripe::Customer.retrieve(self.stripe_id)
        customer.default_card = customer.cards.create(card: stripe_token)
        customer.save
      else
        customer = Stripe::Customer.create(
          description: self.fullname,
          email: self.email,
          card: stripe_token
        )
        self.stripe_id = customer.id
      end
      self.save
      customer
    rescue Stripe::CardError => e
      # catch stripe error here
      # can we console.log an exception?
      # should we raise the exception again to allow it to be passed on to the
      # controller or the view?
      logger.info(e)
      raise
    end
  end

  def charge(amount: nil, description: nil)
    # TODO: validate that there are no decimals in the amount
    raise "There is no credit card saved for this account" unless self.stripe_id
    begin
      charge = Stripe::Charge.create(
        amount: amount, # amount in cents, again
        currency: "usd",
        customer: self.stripe_id,
        description: description
      )
    rescue => e
      logger.info(e)
    end
    charge
  end

  def credit_card
    # instead of saving this in the database, we query Stripe each time we want
    # to get the value of the user's current card
    Stripe::Customer.retrieve(id: self.stripe_id, expand: ['default_card']).default_card if self.stripe_id
  end


  def email_subscribe
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    self.email_contact = true
    if gibbon.lists.members(id: ENV['MAILCHIMP_CAMPAIGN_ID'], email: self.email)
      gibbon.lists.subscribe(id: ENV['MAILCHIMP_CAMPAIGN_ID'],
                             email: {email: self.email},
                             merge_vars: {FNAME: self.fname, LNAME: self.lname},
                             double_optin: false)
    end
  end

  def email_unsubscribe
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    self.email_contact = false
    if gibbon.lists.members(id: ENV['MAILCHIMP_CAMPAIGN_ID'], email: self.email)
      gibbon.lists.unsubscribe(id: ENV['MAILCHIMP_CAMPAIGN_ID'],
                             email: {email: self.email},
                             merge_vars: {FNAME: self.fname, LNAME: self.lname},
                             double_optin: false)
    end
  end

  def sms_subscribe
    self.phone? ? self.sms_contact = true : false
  end

  def sms_unsubscribe
    self.sms_contact=false
  end

  # TODO:
  def registered_for_retreat?
    puts self.retreat_registrations
    self.retreat_registrations.any? {|r|
      puts "Registration: ", r, "Retreat: ", r.retreat, "Retreat id: ", r.retreat.id
      r.retreat.id.equal? Retreat.current.id }
  end

  # TODO:
  def paid_for_retreat?
    self.payments.any? {|p| p.event.id.equal? Retreat.current.id }
  end

  # TODO:
  def retreat_paid_out_of_band
  end
  # Temporary fix for now
  def dues_paid_out_of_band
    if this_years_dues
       if self.payments.build({event_id: this_years_dues.id}).save!
         logger.info "Successfully updated dues status for #{self.fullname}"
       else
         logger.info "Saving the updated dues payment failed for some reason. Try again?"
       end
    else
      logger.info "This year's dues event has not been created yet, create it first!"
    end
  end

  def dues_paid?
    self.paid_events.include? this_years_dues
  end

  def unpaid_events
    paid_events = self.paid_events
    events_requiring_payment = Event.where.not(cost: nil)
    # the set difference of two arrays a & b in ruby is (a - b) | (b - a)
    events_requiring_payment - paid_events | paid_events - events_requiring_payment
  end

  def paid_events
    # TODO: the delete_if call is required to trim payments that have been made
    # for events which have since been deleted. It's important to keep record
    # of these payments, so they shouldn't be destroyed in the database, but
    # their associated events return nil in the database. I'll keep thinking
    # about the best way to handle this.
    self.payments.collect { |p| p.event }.delete_if { |event| event.nil? }
  end

  def has_selected_contact_preference?
    [ :email_contact, :facebook_contact, :sms_contact ].any? do |c|
      self[c]
    end
  end
  def profile_completion_percentage
    required_items = [ :email, :fname, :lname, :phone, :gender, :birthday, :city, :state, :zip, :shirtsize, :email_contact, :facebook_contact, :sms_contact ]
    # count number of empty or nil items, add them up, and divide by total
    # number of required items
    # in a perfect world, Date would respond to the .empty? method so this
    # could be one beautiful line of code
    required_items.map do |k|
      if self[k].respond_to? :empty?
        self[k].empty? ? 0 : 1
      else
        self[k].nil? ? 0 : 1
      end
    end.reduce(:+).to_f / required_items.size * 100
  end

  private
  def this_years_dues
    Event.where(dues: true).detect do |dues|
      dues.startdt.year.equal? DateTime.now.year
    end
  end
end
