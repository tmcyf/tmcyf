class CreateRetreats < ActiveRecord::Migration
  def change
    create_table :retreats do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :line1
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :gender
      t.date :birthday
      t.string :pant_size
      t.string :emergency_contact
      t.string :emergency_contact_relation
      t.string :emergency_contact_number
      t.string :insurance_provider
      t.string :insurance_policy_number
      t.text :allergy_information

      t.timestamps
    end
  end
end
