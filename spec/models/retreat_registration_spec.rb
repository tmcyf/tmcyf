require 'spec_helper'

describe RetreatRegistration do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
  end

  describe "payment verification" do
    it "should return false for a user that hasn't paid" do
      @registration = create(:retreat_registration, {user: @user1})
      @registration.paid?.should == false
    end

    it "should return true for a user that's paid" do
      @registration = create(:retreat_registration, {user: @user1})
      create(:payment, {user: @user1, event_id: @registration.retreat_id})
      @registration.paid?.should == true
    end
  end
end

