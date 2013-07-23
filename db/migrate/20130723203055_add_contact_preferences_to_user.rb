class AddContactPreferencesToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_contact, :boolean
    add_column :users, :facebook_contact, :boolean
    add_column :users, :sms_contact, :boolean
  end
end
