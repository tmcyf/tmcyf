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

  it "should strip phone numbers" do
    bad_numbers = %w[(832)-603-9372 832-603-9372 832.603.9372]
    bad_numbers.each do |number|
      user_with_stripped_number = User.create(@attr.merge(phone: number))
      expect(user_with_stripped_number.phone).to eq('8326039372')
    end
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
