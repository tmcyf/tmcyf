class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :description
      t.references :payable, polymorphic: true
    end
  end
end
