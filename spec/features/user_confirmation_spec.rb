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
      page.should have_content "Register"
      fill_in "user_fname", :with => @user.fname
      fill_in "user_lname", :with => @user.lname
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => "foobar2000"
      fill_in "user_password_confirmation", :with => "foobar2000"
      click_button "Sign up"
      page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
      ActionMailer::Base.deliveries.last.to.should == [@user.email]
      token = extract_token_from_email(:confirmation)
      visit user_confirmation_path(@user, confirmation_token: token)
      page.should have_content "Great! Your account was successfully confirmed! Login to get started!"
    end
  end
end