
require 'spec_helper'

describe "Admin" do

  it "should be inaccessible before sign-in" do
    visit "/admin2"
    page.should have_content("You need to sign in")
  end
  
  it "should be inaccessible for non-admins" do
    @user = create(:user)
    visit "/login"
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Sign in"
    visit "/admin2"
    page.should have_content("You are not an admin")
  end

  it "should be accessible for admins" do
    @user = create(:admin)
    visit "/login"
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Sign in"
    visit "/admin2"
    page.should have_content("")
  end
end
