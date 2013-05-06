class RemoveHomeAddressIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :home_address_id
  end

  def down
    add_column :users, :home_address_id, :integer
  end
end
