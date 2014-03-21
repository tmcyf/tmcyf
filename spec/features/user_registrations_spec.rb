require 'spec_helper'
require 'helpers/auth_helpers.rb'
include Features
include AuthHelpers

describe "UserRegistrations" do
  describe "Sign up page" do
    it "works" do
      register
      page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
      User.last.email_contact.should be_true
    end
  end

  describe "Sign in page" do
    it "works" do
      sign_in
      page.should have_content "Signed in successfully"
    end
  end
end
