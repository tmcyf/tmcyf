class AddActiveToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :active, :boolean
  end
end
