class RemoveExpirationFromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :expiration
  end

  def down
    add_column :rides, :expiration, :datetime
  end
end
