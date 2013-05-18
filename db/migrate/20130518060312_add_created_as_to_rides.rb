class AddCreatedAsToRides < ActiveRecord::Migration
  def change
    add_column :rides, :created_as, :string
  end
end
