require 'spec_helper'
require 'helpers/devise_mail_helpers.rb'
include Features
include MailHelpers

describe "UserConfirmation" do
  describe "User confirmation page" do
    before do
      @user = FactoryGirl.build(:user)
    end
    it "sends account confirmation email" do
      visit new_user_registration_path
      expect(page).to have_content "Register"
      fill_in "user_fname", with: @user.fname
      fill_in "user_lname", with: @user.lname
      fill_in "user_line1", with: @user.line1
      fill_in "user_city", with: @user.city
      fill_in "user_state", with: @user.state
      fill_in "user_zip", with: @user.zip
      fill_in "user_phone", with: @user.phone
      select @user.gender, from: "user_gender"
      select "August", from: "user_birthday_2i"
      select "22", from: "user_birthday_3i"
      select "1992", from: "user_birthday_1i"
      select @user.shirtsize, from: "user_shirtsize"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password
      click_button "Sign up"
      expect(page).to have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
      expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
      token = extract_token_from_email(:confirmation)
      visit user_confirmation_path(@user, confirmation_token: token)
      expect(page).to have_content "Great! Your account was successfully confirmed! Login to get started!"
    end
  end
end
