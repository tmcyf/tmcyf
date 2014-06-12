class CreateWomensRetreatRegistrations < ActiveRecord::Migration
  def change
    create_table :womens_retreat_registrations do |t|
      t.string :fname
      t.string :lname
      t.date :birthday
      t.string :address
      t.string :phone
      t.integer :age
      t.integer :academic_classification
      t.integer :parish
      t.boolean :accommodations

      t.timestamps
    end
  end
end
