class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books 
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id' ,dependent: :destroy
  #ユーザーはたくさんフォローした人のIDを持てる　ユーザー削除で消える
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id' ,dependent: :destroy
  #ユーザーはフォローされた人のIDをもてる　ユーザー削除で消える

  has_many :followings, through: :follower_relationships, source: :followed
  #follower_relationshipを通してfollowerを取得する =フォローしているユーザーを取得
  has_many :followers, through: :followed_relationships, source: :follower
  #followeed_relationshipを通してfollowedを取得する =フォロワーを取得

  #指定したユーザーをフォローするメソッド
  def follow(user)
    follower_relationships.create(followed_id: user.id)
  end
  
  #指定したユーザーのフォローを解除するメソッド
  def unfollow(user)
    follower_relationships.find_by(followed_id: user.id).destroy
    #find_byメソッドで該当する引数を探す
  end
  
  # 指定したユーザーをフォローしているかどうかを？で判定
  def following?(user)
    followings.include?(user)
  end


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
