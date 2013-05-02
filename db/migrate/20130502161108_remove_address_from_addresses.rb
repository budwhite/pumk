class RemoveAddressFromAddresses < ActiveRecord::Migration
  def up
    remove_column :addresses, :address
  end

  def down
    add_column :addresses, :address, :string
  end
end
