require 'spec_helper'

describe "Pages" do

  let(:base_title) { "Trinity Mar Thoma Church Youth Fellowship" }

  describe "About page" do

    it "should have the content 'About'" do
      visit '/about'
      expect(page).to have_content('About')
    end

    it "should have the title 'About'" do
      visit '/about'
      expect(page).to have_title("About | #{base_title}")
    end
  end

  describe "Bible Study page" do

    it "should have the content 'Bible Study'" do
      visit '/biblestudy'
      expect(page).to have_content('Bible Study')
    end

    it "should have the title 'Bible Study'" do
      visit '/biblestudy'
      expect(page).to have_title("Bible Study | #{base_title}")
    end
  end

  describe "Account page" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end

    it "should have the content 'Account'" do
      visit '/account'
      expect(page).to have_content('Account')
    end

    it "should have the title 'Account'" do
      visit '/account'
      expect(page).to have_title("Edit profile | #{base_title}")
    end
  end

  describe "Preferences page" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end

    it "should have the content 'Preferences'" do
      visit '/account/preferences'
      expect(page).to have_content('Preferences')
    end

    it "should have the title 'Preferences'" do
      visit '/account/preferences'
      expect(page).to have_title("Preferences | #{base_title}")
    end
  end

  describe "Privacy Policy page" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end

    it "should have the content 'Privacy Policy'" do
      visit '/privacy_policy'
      expect(page).to have_content('Privacy Policy')
    end

    it "should have the title 'Privacy Policy'" do
      visit '/privacy_policy'
      expect(page).to have_title("Privacy Policy | #{base_title}")
    end
  end

  describe "Give page" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end

    it "should have the content 'Give'" do
      visit '/give'
      expect(page).to have_content('Give')
    end

    it "should have the title 'Give'" do
      visit '/give'
      expect(page).to have_title("Give | #{base_title}")
    end
  end
end