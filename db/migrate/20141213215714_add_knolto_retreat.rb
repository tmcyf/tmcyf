class AddKnoltoRetreat < ActiveRecord::Migration
  def change
    add_column :retreats, :level, :string
  end
end
