class AddSchedule1ToRides < ActiveRecord::Migration
  def change
    add_column :rides, :schedule1, :text
  end
end
