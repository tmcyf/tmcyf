require 'spec_helper'

describe "PasswordResets" do
  describe "Password reset page" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it "works" do
      visit new_user_password_path
      page.should have_content "Forgot your password?"
      fill_in "user_email", with: @user.email
      click_button "Send me reset password instructions"
      page.should have_content "You will receive an email with instructions about how to reset your password in a few minutes."
      ActionMailer::Base.deliveries.last.to.should == [@user.email]
    end
  end
end