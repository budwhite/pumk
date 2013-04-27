class AddHomeAddressIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_address_id, :integer
  end
end
