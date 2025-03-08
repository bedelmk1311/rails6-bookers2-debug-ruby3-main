class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books #, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id' dependent: :destroy
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id' dependent: :destroy
  #ユーザーはたくさんフォローした人のIDを持てる　ユーザー削除で消える
  #ユーザーはフォローされた人のIDをもてる　ユーザー削除で消える

  has_many :follower_relationships, through: :relationship, source: :follower
  #relationshipを通してfollowerを取得する？
  has_many :followed_relationships, through: :relationship, source: :followed
  #relationshipを通してfollowedを取得する？
  
  #仮の命名した上で中間テーブルのre~テーブルを通してfo~テーブルからデータを取得できるように

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    #足りない気がする
  end
end
