class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :grade
      t.string :teacher

      t.timestamps
    end
  end
end
