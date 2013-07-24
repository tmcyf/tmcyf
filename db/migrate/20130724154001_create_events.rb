class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :title
    	t.text	:body
    	t.date	:date
    	t.time :time
    	t.integer :img_id
    	t.string :location
    end
  end
end
