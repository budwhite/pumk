class AddCreatedByToRides < ActiveRecord::Migration
  def change
    add_column :rides, :created_by, :integer
  end
end
