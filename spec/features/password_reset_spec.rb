require 'spec_helper'
require 'helpers/devise_mail_helpers.rb'
include Features
include MailHelpers

describe "PasswordResets" do
  describe "Password reset page" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it "sends password reset email" do
      visit new_user_password_path
      expect(page).to have_content "Forgot your password?"
      fill_in "user_email", with: @user.email
      click_button "Send me reset password instructions"
      expect(page).to have_content "You will receive an email with instructions about how to reset your password in a few minutes."
      expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
      token = extract_token_from_email(:reset_password)
      visit edit_user_password_path(@user, reset_password_token: token)
      fill_in "user_password", with: "foobar2000"
      fill_in "user_password_confirmation", with: "foobar2000"
      click_button "Change my password"
      expect(page).to have_content "Your password was changed successfully. You are now signed in."
    end
  end
end
