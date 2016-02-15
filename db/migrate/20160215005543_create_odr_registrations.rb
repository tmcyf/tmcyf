class CreateOdrRegistrations < ActiveRecord::Migration
  def change
    create_table :odr_registrations do |t|
      t.string :email
      t.string :fname
      t.string :lname
      t.string :parish
      t.integer :age
      t.string :shirt_size
      t.string  :payment_method
    end
  end
end
