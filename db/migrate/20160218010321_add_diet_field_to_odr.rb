class AddDietFieldToOdr < ActiveRecord::Migration
  def change
    add_column :odr_registrations, :diet, :text
  end
end
