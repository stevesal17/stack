class ChangeCommentFields < ActiveRecord::Migration
  def change
  	change_column :comments, :body, :text
  	remove_column :comments, :text
  end
end
