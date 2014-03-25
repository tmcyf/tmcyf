require 'spec_helper'
require 'helpers/auth_helpers.rb'
include Features
include AuthHelpers

describe "Admin" do

  it "should be inaccessible before sign-in" do
    visit "/admin2"
    expect(page).to have_content("You need to sign in")
  end

  it "should be inaccessible for non-admins" do
    sign_in
    visit "/admin2"
    expect(page).to have_content("You are not an admin")
  end

  it "should be accessible for admins" do
    sign_in_admin
    visit "/admin2"
    expect(page).to have_content("")
  end
end
