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

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      fname: "Baz",
      lname: "Qux",
      line1: "5810 Almeda-Genoa Rd",
      city: "Houston",
      state: "TX",
      zip: "77048",
      phone: "7139911557",
      gender: "Male",
      birthday: "#{18.years.ago}",
      shirtsize: "L",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should opt-in each new user to the mailing list after create" do
    user = User.create!(@attr)
    expect(user.email_contact).to be_true
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    expect(no_email_user).not_to be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      expect(invalid_email_user).not_to be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      expect(@user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      expect(User.new(@attr.merge(password: "", password_confirmation: ""))).
        not_to be_valid
    end

    it "should require a matching password confirmation" do
      expect(User.new(@attr.merge(password_confirmation: "invalid"))).
        not_to be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(password: short, password_confirmation: short)
      expect(User.new(hash)).not_to be_valid
    end
  end
end
