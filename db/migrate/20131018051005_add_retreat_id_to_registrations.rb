class AddRetreatIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :retreat_registrations, :retreat_id, :integer
  end
end
