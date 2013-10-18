class AddRetreatIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :retreat_registrations, :retreat_id, :integer
    drop_table :retreats
  end
end
