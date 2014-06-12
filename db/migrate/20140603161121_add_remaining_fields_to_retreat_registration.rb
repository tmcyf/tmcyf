class AddRemainingFieldsToRetreatRegistration < ActiveRecord::Migration
  def change
    add_column :womens_retreat_registrations, :restrictions, :text
    add_column :womens_retreat_registrations, :medical_conditions, :text
    add_column :womens_retreat_registrations, :insurance_info, :text
    add_column :womens_retreat_registrations, :ec_name, :string
    add_column :womens_retreat_registrations, :ec_phone, :string
    add_column :womens_retreat_registrations, :ec_relationship, :string
    add_column :womens_retreat_registrations, :payment_method, :integer
  end
end
