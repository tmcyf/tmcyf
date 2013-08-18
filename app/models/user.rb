class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  has_many :credit_cards
  has_many :payments, through: :credit_cards
  
  def fullname
  	self.fname + self.lname
  end

  def address
  	self.line1 + self.city + self.state + self.zip
  end

  # TODO: should I run this in an after_create hook? in the controller?
  def create_stripe_id
    self.stripe_id = Stripe::Customer.create(
      description: self.fullname,
    ).id
  end
  def add_card(stripe_token)
    # TODO: wrap calls to the stripe API in begin/rescue/end blocks
    if self.stripe_id
      customer = Stripe::Customer.retrieve(self.stripe_id)
      customer.cards.create(card: stripe_token)
    else
      customer = Stripe::Customer.create(
        description: self.fullname,
        card: stripe_token
      )
      self.stripe_id = customer.id
    end
    customer
  end

  def credit_card_list
    self.create_stripe_id unless self.stripe_id
    Stripe::Customer.retrieve(self.stripe_id).cards.all
  end


  def email_subscribe
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    self.email_contact = true 
    if !gibbon.lists.members(id: "4c04c52ede", email: self.email)
      gibbon.lists.subscribe(id: "4c04c52ede", 
                             email: {email: self.email},
                             merge_vars: {FNAME: self.fname, LNAME: self.lname},
                             double_optin: false)
    end
  end
  def email_unsubscribe
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    self.email_contact = false 
    if gibbon.lists.members(id: "4c04c52ede", email: self.email)
      gibbon.lists.unsubscribe(id: "4c04c52ede", 
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
end
