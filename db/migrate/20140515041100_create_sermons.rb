class CreateSermons < ActiveRecord::Migration
  def change
    create_table :sermons do |t|
      t.string :title
      t.text :notes
      t.string :audio

      t.timestamps
    end
  end
end
