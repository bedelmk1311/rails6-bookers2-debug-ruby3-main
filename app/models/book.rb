class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #関連付け

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    #favorites.where(user_id: user.id).exists? サンプル答え版

  end
  #exists存在する favorited_by?メソッド作成
  #(引数で渡されたユーザid)がFavoritesテーブル内に存在するかどうか
  #books/showでcurrent_userが含まれるかどうかを判定する
end
