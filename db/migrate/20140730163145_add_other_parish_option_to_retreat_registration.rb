class AddOtherParishOptionToRetreatRegistration < ActiveRecord::Migration
  def change
  	add_column :womens_retreat_registrations, :otherparish, :string
  end
end
