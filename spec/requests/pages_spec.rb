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
end