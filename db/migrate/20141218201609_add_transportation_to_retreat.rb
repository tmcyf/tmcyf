class AddTransportationToRetreat < ActiveRecord::Migration
  def change
    add_column :retreats, :transportation, :string
  end
end
