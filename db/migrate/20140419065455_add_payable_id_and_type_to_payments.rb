class AddPayableIdAndTypeToPayments < ActiveRecord::Migration
  def change
    change_table :payments do |t|
      t.references :payable, polymorphic: true
    end
  end
end
