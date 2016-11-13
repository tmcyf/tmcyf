class AddPolicyConfirmationToRetreats < ActiveRecord::Migration
  def change
    add_column :retreats, :policy_confirmation, :boolean, default: false
  end
end
