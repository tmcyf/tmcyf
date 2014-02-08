class RemoveRetreatRegistrations < ActiveRecord::Migration
  def up
    drop_table :retreat_registrations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
