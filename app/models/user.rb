# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  fname                  :string(255)
#  lname                  :string(255)
#  phone                  :string(255)
#  gender                 :string(255)
#  birthday               :date
#  line1                  :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :string(255)
#  shirtsize              :string(255)
#  email_contact          :boolean          default(FALSE)
#  facebook_contact       :boolean          default(FALSE)
#  sms_contact            :boolean          default(FALSE)
#  admin                  :boolean          default(FALSE)
#  stripe_id              :string(255)
#  status                 :integer          default(0)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable

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
