class AddChildIdToRiderships < ActiveRecord::Migration
  def change
    add_column :riderships, :child_id, :integer
  end
end
