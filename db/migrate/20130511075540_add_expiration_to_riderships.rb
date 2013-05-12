class AddExpirationToRiderships < ActiveRecord::Migration
  def change
    add_column :riderships, :expiration, :timestamp
  end
end
