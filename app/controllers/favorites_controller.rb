class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
     #favorite = Favorite.new(favorite_params)
     #いいね作成
     #favorite.user_id = current_user.id と同義？
    favorite.save
    redirect_to book_path(book)
  end
    
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    #find_byメソッド　条件を指定して最初の1件を取得（該当する一個だけ）
    favorite.destroy
    redirect_to book_path(book)
  end

end
