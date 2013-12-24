class AddStripeIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :stripe_id, :string
  end
end
