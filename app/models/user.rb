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

	# ideally, this is done in the controller, but modifying Devise controllers
	# is less straightforward than simply instantiating a mailman here
	def auto_optin
		mailman = Mailman.new
		mailman.subscribe(self)
	end

  def fullname
    self.fname ? self.fname + " " + self.lname : nil
  end

  def address
    self.line1 + self.city + self.state + self.zip
  end


  def sms_subscribe
    self.phone? ? self.sms_contact = true : false
  end

  def sms_unsubscribe
    self.sms_contact=false
  end
end
