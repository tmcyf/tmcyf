class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :cumulative_amount_paid, :decimal
  end
end
