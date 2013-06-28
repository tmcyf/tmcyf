class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :address
      t.string :phone
      t.string :string
      t.string :gender
      t.date :birthday
      t.decimal :cumulative_amount_paid

      t.timestamps
    end
  end
end
