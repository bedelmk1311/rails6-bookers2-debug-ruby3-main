class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #関連付け

  def self.search_for(keyword, method)
    if method == 'perfect'
      Book.where(name: keyword)
    elsif method == 'forward'
      Book.where('name LIKE ?', keyword + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + keyword)
    else
      Book.where('name LIKE ?', '%' + keyword + '%')
    end
  end

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
