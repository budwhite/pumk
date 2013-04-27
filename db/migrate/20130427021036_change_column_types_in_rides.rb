class ChangeColumnTypesInRides < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table rides
      alter column origin_address_id
      type integer using cast(origin_address_id as integer)
    })
    connection.execute(%q{
      alter table rides
      alter column destination_address_id
      type integer using cast(destination_address_id as integer)
    })
  end

  def down
    change_column :rides, :origin_address_id, :string
    change_column :rides, :destination_address_id, :string
  end
end
