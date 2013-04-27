class ChangeDriverIdFormatInRides < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table rides
      alter column driver_id
      type integer using cast(driver_id as integer)
    })
  end

  def down
    change_column :rides, :driver_id, :string
  end
end
