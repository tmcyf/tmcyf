require 'spec_helper'
# require 'helpers/auth_helpers.rb'
# include Features
# include AuthHelpers

describe "ODR_Registrations" do
  describe "Sign up page" do
    it "works" do
      visit "/the-faith-awakens"
      expect(page).to have_content "The Faith Awakens"
      fill_in "odr_registration_email", with: "test@email.com"
      fill_in "odr_registration_fname", with: "Baz"
      fill_in "odr_registration_lname", with: "Quz"
      fill_in "odr_registration_parish", with: "Trinity"
      fill_in "odr_registration_age", with: "18"
      select "L", from: "odr_registration_shirt_size"
      fill_in "odr_registration_diet", with: "lead please"
      choose('Online')
      click_button "Submit"
      expect(page).to have_content "Successfully registered!"
      expect(ActionMailer::Base.deliveries.last.to).to eq(["test@email.com"])
    end
  end
end
