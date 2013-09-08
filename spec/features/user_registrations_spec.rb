require 'spec_helper'

describe "UserRegistrations" do
  describe "Sign up" do
    it "Sign up page works" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit "/register"
      fill_in "user_email", with: "bgmuthalaly@gmail.com"
      fill_in "user_password", with: "bertbert"
      fill_in "user_password_confirmation", with: "bertbert"
      click_button "Sign up"
      page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    end
  end
end
