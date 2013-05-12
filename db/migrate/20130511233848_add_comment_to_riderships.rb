class AddCommentToRiderships < ActiveRecord::Migration
  def change
    add_column :riderships, :comment, :text
  end
end
