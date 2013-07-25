class RemoveExtraneousShit < ActiveRecord::Migration
  def change
  	remove_column :events, :img_url
  end
end
