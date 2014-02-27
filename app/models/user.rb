class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  after_create :auto_optin

  before_validation(on: :update) do
    self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
  end

  validates_format_of :phone, :with => /\d*[1-9]\d*/i, :on => :update, message: "This isn't a valid number!", :allow_blank => true, :allow_nil => true

  def fullname
    self.fname ? self.fname + " " + self.lname : nil
  end

  def address
    self.line1 + self.city + self.state + self.zip
  end

  def auto_optin
    gibbon = Gibbon::API.new
    Gibbon::API.throws_exceptions = false
    self.email_contact = true
    self.save
    if gibbon.lists.members(id: ENV['MAILCHIMP_CAMPAIGN_ID'], email: self.email)
      gibbon.lists.subscribe(id: ENV['MAILCHIMP_CAMPAIGN_ID'],
                             email: {email: self.email},
                             merge_vars: {FNAME: self.fname, LNAME: self.lname},
                             double_optin: false)
    end
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

  def self.to_xls
    # an xls file is just a CSV with tabs as delimiters
    CSV.generate(col_sep: "\t") do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
