class ChangeDataTypesForRetreatRegistration < ActiveRecord::Migration
  def change
    change_column :womens_retreat_registrations, :academic_classification, :string
    change_column :womens_retreat_registrations, :parish, :string
    change_column :womens_retreat_registrations, :payment_method, :string
  end
end
