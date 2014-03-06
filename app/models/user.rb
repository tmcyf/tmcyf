class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  after_create :auto_optin

  before_validation(on: :create) do
    self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
  end

  before_validation(on: :update) do
    self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
  end

  validates_format_of :phone, with: /\d*[1-9]\d*/i, on: :update, message: "This isn't a valid number!", allow_blank: true, allow_nil: true
  validates_format_of :phone, with: /\d*[1-9]\d*/i, on: :create, message: "This isn't a valid number!", allow_blank: true, allow_nil: true
  validates_format_of :email, with: /.+@.+\..+/i, on: :create, message: "This isn't a valid email address."
  validates_format_of :email, with: /.+@.+\..+/i, on: :update, message: "This isn't a valid email address."

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
