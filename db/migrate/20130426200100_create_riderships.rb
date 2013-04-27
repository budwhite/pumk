class CreateRiderships < ActiveRecord::Migration
  def change
    create_table :riderships do |t|
      t.integer :ride_id
      t.integer :user_id

      t.timestamps
    end
  end
end
