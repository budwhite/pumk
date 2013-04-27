class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :status
      t.integer :gas_money
      t.integer :seats_total
      t.integer :seats_filled
      t.text :schedule
      t.string :origin_address_id
      t.string :destination_address_id
      t.string :driver_id
      t.string :ride_type

      t.timestamps
    end
  end
end
