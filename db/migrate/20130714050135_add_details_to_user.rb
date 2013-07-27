class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :line1, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :shirtsize, :string
    add_column :users, :email_contact, :boolean
    add_column :users, :facebook_contact, :boolean
    add_column :users, :sms_contact, :boolean
    add_column :users, :admin, :boolean, :default => false
  end
end
