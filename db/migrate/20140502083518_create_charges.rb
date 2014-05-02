class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :stripe_id
      t.string :last4
      t.decimal :amount
      t.integer :user_id
      t.integer :payment_id
    end
  end
end
