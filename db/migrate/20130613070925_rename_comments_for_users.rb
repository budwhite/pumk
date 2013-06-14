class RenameCommentsForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :comments, :comment
  end
end
