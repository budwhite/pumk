class RemoveSchedule1FromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :schedule1
  end

  def down
    add_column :rides, :schedule1, :text
  end
end
