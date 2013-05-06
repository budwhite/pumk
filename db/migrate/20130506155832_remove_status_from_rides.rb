class RemoveStatusFromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :status
  end

  def down
    add_column :rides, :status, :string
  end
end
