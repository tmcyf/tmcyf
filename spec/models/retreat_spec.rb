require 'spec_helper'

describe Retreat do
  before :each do
    @retreat = create(:retreat)
    @user = create(:user)
  end

  describe "csv" do
    it "should export all retreat registration attributes to a csv" do
      # generate users, generate retreat, register users for retreat
      registration_params = @user.attributes.except("id", "reset_password_token", 
        "reset_password_sent_at", "remember_created_at", "sign_in_count", 
        "current_sign_in_at", "last_sign_in_at", "current_sign_in_ip", 
        "last_sign_in_ip", "confirmation_token", "confirmed_at", 
        "confirmation_sent_at", "authentication_token", "created_at", 
        "email_contact", "facebook_contact", "sms_contact", "admin", "stripe_id",
        "updated_at", "encrypted_password").merge({
          emergency_contact: "prolly ivan",
          emergency_phone: "prolly not",
          emergency_relation: "prolly ur mom",
          insurance_policy_number: "8675309",
          days_attending: 2,
          retreat_id: @retreat.id
        })
      @registration = RetreatRegistration.create(registration_params)
      @csv = @retreat.to_csv
      csv_data = CSV.parse(@csv)
      # number of columns should equal registration num columns
      csv_data.first.length.should == (RetreatRegistration.column_names.length) 
      # number of rows should equal number of registrations plus 1 (for header)
      csv_data.length.should == (@retreat.retreat_registrations.length + 1)
    end
  end
end
