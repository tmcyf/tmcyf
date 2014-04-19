class AddNameToGenericPayable < ActiveRecord::Migration
  def change
    add_column :generic_payables, :name, :string
  end
end
