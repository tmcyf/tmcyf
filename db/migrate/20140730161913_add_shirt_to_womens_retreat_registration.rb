class AddShirtToWomensRetreatRegistration < ActiveRecord::Migration
  def change
  	add_column :womens_retreat_registrations, :shirtsize, :string
  end
end
