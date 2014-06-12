class AddEmailToWomensRetreatRegistration < ActiveRecord::Migration
  def change
  	add_column :womens_retreat_registrations, :email, :string
  end
end
