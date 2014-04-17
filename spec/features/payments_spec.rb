require 'spec_helper'

describe "Payments" do
  let(:admin) { create(:admin) }
  before :each do
    visit "/login"
    fill_in "user_email", with: admin.email
    fill_in "user_password", with: admin.password
    click_button "Sign in"
  end
    
  it "should be accessible from the admin dashboard" do
    visit "/admin"
    click_link "New Payment"
    fill_in "amount", with: 10.00
    fill_in "description", with: "A required payment"
    click_button "Submit"
  end
end
