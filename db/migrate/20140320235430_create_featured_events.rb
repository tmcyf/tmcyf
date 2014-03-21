class CreateFeaturedEvents < ActiveRecord::Migration
  def change
    create_table :featured_events do |t|
      t.string :image_url
      t.string :event_url

      t.timestamps
    end
  end
end
