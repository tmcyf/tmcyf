class AddCurrentCardLast4ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_last4, :string
  end
end
