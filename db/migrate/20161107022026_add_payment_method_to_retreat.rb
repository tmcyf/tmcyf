class AddPaymentMethodToRetreat < ActiveRecord::Migration
  def change
    add_column :retreats, :payment_method, :string
  end
end
