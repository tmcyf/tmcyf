class RemoveCostAndDuesFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :dues
    remove_column :events, :cost
  end
end
