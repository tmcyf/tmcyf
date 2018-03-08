class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  has_many :charges
  has_many :payments, through: :charges

  before_validation :strip_phone_number

  validates_format_of :email, with: /.+@.+\..+/i, message: "This isn't a valid email address."
  validates_format_of :phone, with: /\d*[1-9]\d*/i, message: "This isn't a valid number!", allow_blank: true, allow_nil: true

  validates_presence_of :fname, :lname, :line1, :city, :state, :zip, :phone, :gender, :birthday, :shirtsize, :email

  enum status: { registered: 0, active: 1, paid: 2 }

  def fullname
    "#{self.fname} #{self.lname}"
  end

  def sms_subscribe
    self.phone? ? self.sms_contact = true : false
  end

  def sms_unsubscribe
    self.sms_contact=false
  end

  protected
    def strip_phone_number
      self.phone = phone.gsub(/[^0-9]/, "") if attribute_present?("phone")
    end
end
