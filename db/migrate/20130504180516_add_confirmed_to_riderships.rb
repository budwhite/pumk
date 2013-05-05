class AddConfirmedToRiderships < ActiveRecord::Migration
  def change
    add_column :riderships, :confirmed, :boolean
  end
end
