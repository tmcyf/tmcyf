class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  has_many :charges
  has_many :payments, through: :charges

  before_validation(on: :create, on: :update) do
    self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
  end

  validates_format_of :email, with: /.+@.+\..+/i, on: :create, on: :update, message: "This isn't a valid email address."
  validates_format_of :phone, with: /\d*[1-9]\d*/i, on: :create, on: :update, message: "This isn't a valid number!", allow_blank: true, allow_nil: true

  validates_presence_of :fname, :lname, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirtsize, :email

  scope :prefers_emails, -> { where(email_contact: true) }
  scope :prefers_sms, -> { where(sms_contact: true) }
  scope :prefers_fb, -> { where(facebook_contact: true) }

  enum status: { registered: 0, active: 1 }

  def fullname
    "#{self.fname} #{self.lname}"
  end

  def fullname
    "#{self.fname} #{self.lname}"
  end


  def sms_subscribe
    self.phone? ? self.sms_contact = true : false
  end

  def sms_unsubscribe
    self.sms_contact=false
  end
end
