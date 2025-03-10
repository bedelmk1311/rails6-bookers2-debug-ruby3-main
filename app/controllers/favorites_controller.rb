class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
     #favorite = Favorite.new(favorite_params)
     #現在のユーザーのいいねを作成
     #favorite.user_id = current_user.id と同義？
    favorite.save
    #redirect_to request.referer

  end
    
  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    #find_byメソッド　条件を指定して最初の1件を取得（該当する一個だけ）
    favorite.destroy
    #redirect_to request.referer
    
  end

end
