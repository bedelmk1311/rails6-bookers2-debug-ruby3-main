class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  #要確認　投稿者だけが削除の権限持たせたい

  def create
    book = Book.find(params[:comment_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.comment_id = book.id
    comment.save
    redirect_to books_path(book)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
    unless @book_comment.user == current_user
      redirect_to books_path
    end
  end

end
