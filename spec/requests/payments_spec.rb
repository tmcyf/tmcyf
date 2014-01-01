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

end

