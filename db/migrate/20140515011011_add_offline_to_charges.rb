class AddOfflineToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :offline, :boolean
  end
end
