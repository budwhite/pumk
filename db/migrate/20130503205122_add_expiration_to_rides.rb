class AddExpirationToRides < ActiveRecord::Migration
  def change
    add_column :rides, :expiration, :timestamp
  end
end
