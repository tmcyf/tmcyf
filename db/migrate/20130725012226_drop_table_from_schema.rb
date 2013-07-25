class DropTableFromSchema < ActiveRecord::Migration
  def change
  	drop_table :articles
  	remove_column :events, :img_id
  end
end
