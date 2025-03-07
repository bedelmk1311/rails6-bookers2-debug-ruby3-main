class RemoveCommentIdFromBookComment < ActiveRecord::Migration[6.1]
  def change
    remove_column :book_comments, :comment_id, :integer
  end
end
