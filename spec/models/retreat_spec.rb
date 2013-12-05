require 'spec_helper'

describe Retreat do
  before :each do
    @retreat = create(:retreat)
    @user = create(:user)
  end

  describe "csv" do
    it "should export all retreat registration attributes to a csv" do
      @registration = create(:retreat_registration,
                             {retreat: @retreat, user: @user})

      @csv = @retreat.to_csv
      csv_data = CSV.parse(@csv)
      # number of columns should equal registration num columns
      csv_data.first.length.should == (RetreatRegistration.column_names.length) 
      # number of rows should equal number of registrations plus 1 (for header)
      csv_data.length.should == (@retreat.retreat_registrations.length + 1)
    end
  end
end
