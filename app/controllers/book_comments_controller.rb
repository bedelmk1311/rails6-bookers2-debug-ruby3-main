class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  #要確認　投稿者だけが削除の権限持たせたい

  def create
    book = Book.find(params[:book_id])
    #コメントがついた投稿のIDを取得する
    comment = current_user.book_comments.new(book_comment_params)
     #comment = BookComment.new(book_comment_params)
     #コメント作成
     #comment.user_id = current_user.id
    comment.book_id = book.id
    #コメント本文　コメントがついた投稿のID　コメントが投稿のIDと同じ？
    comment.save
    #コメント本文を保存
    redirect_to book_path(book)
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
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
