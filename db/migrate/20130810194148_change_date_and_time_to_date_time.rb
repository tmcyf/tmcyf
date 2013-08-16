class ChangeDateAndTimeToDateTime < ActiveRecord::Migration
  def change
  	remove_column :events, :date, :date
  	remove_column :events, :time, :time
  	add_column    :events, :startdt, :datetime
  	add_column    :events, :enddt, :datetime
  end
end
