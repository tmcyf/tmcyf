require 'spec_helper'

describe "Payments" do
  before do
    @user = create :user
    @event = create :event
    visit "/login"
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Sign in"
  end
  
  it "should show payment for event on payments page" do
    visit account_payments_path
    expect(page).to have_content('Pay')
  end

  it "should not allow payment without a credit card" do
    visit account_payments_path
    click_button "Pay"
    expect(page).to have_content('Please provide a valid credit card')
  end

  it "should allow payment after entering a valid credit card", js: true do
    visit account_payments_path
    # Credit card creation. Can these steps be factored out into a helper?
    fill_in "card_number", with: "4242424242424242"
    fill_in "card_code", with: "000"
    page.select "January", from: "card_month"
    page.select "2015", from: "card_year"
    click_button "Save Credit Card"
    # end credit card creation
    # binding.pry
    click_button "Pay"
    page.should have_content('Payment has been made')
  end

end

