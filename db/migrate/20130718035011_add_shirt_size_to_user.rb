class AddShirtSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :shirtsize, :string
  end
end
