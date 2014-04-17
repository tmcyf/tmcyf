class CreateGenericPayables < ActiveRecord::Migration
  def change
    create_table :generic_payables do |t|
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
