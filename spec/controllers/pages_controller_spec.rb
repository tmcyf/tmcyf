require 'rails_helper'

describe PagesController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      expect(response).to be_success
    end
  end

end