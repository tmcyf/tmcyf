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
    fill_in "payment_amount", with: 10.00
    fill_in "payment_description", with: "A required payment"
    click_button "Create Payment"
  end

  it "should have an accessible payments page for users" do
    visit "/payments"
    expect(page).to have_content "Payments"
  end

  it "should render created payables on the accounts page" do
    payment = create(:payment)
    visit "/payments"
    expect(page).to have_content payment.description
  end

end
