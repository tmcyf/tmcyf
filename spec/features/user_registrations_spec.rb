require 'spec_helper'
require 'helpers/auth_helpers.rb'
include Features
include AuthHelpers

describe "UserRegistrations" do
  describe "Sign up page" do
    it "works" do
      register
      expect(page).to have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
      expect(User.last.email_contact).to be_true
    end
  end

  describe "Sign in page" do
    it "works" do
      sign_in
      expect(page).to have_content "Signed in successfully"
    end
  end
end
