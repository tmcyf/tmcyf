class AddPaidColumnToRetreatRegistrations < ActiveRecord::Migration
  def change
    change_table :retreat_registrations do |t|
      t.boolean :paid
    end
  end
end
