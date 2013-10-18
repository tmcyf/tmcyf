class ChangeStartdtAndEnddtToDaysAttending < ActiveRecord::Migration
  def change
    add_column :retreat_registrations, :days_attending, :integer
    remove_column :retreat_registrations, :start_date
    remove_column :retreat_registrations, :end_date
  end
end
