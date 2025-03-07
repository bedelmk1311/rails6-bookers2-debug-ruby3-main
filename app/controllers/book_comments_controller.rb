class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  #要確認　投稿者だけが削除の権限持たせたい

  def create
    book = Book.find(params[:comment_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.comment_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:comment_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
    #book_commentのcommentを指定（許可する）
  end

  def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
    unless @book_comment.user == current_user
      redirect_to books_path
    end
  end

end
