class RemoveConfirmedFromRiderships < ActiveRecord::Migration
  def up
    remove_column :riderships, :confirmed
  end

  def down
    add_column :riderships, :confirmed, :boolean
  end
end
