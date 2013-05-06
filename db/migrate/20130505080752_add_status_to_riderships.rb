class AddStatusToRiderships < ActiveRecord::Migration
  def change
    add_column :riderships, :status, :string
  end
end
