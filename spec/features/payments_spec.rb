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
  end

  it "should successfully create new payments" do
    visit "/admin"
    click_link "New Payment"
    # puts page.body
    # too much coupling to the specifics of the page
    fill_in "generic_payable_amount", with: 10.00
    fill_in "generic_payable_description", with: "A required payment"
    click_button "Create Special Payment"
  end

  it "should have an accessible payments page for users" do
    visit "account/payments"
    page.should have_content "Payments"
  end

  it "should render created payables on the accounts page" do
    payable = create(:generic_payable)
    visit "account/payments"
    page.should have_content payable.description
  end

  it "should show users the option to make payments for payable items" do
    payable = create(:generic_payable)
    visit "account/payments"
    page.should have_content "Make Payment"
  end

end
