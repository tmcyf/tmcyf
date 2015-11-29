class ChangeRetreatAttributes < ActiveRecord::Migration
  def change
    rename_column :retreats, :pant_size, :shirt_size
    remove_column :retreats, :level
  end
end
