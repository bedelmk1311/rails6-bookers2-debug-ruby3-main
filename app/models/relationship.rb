class Relationship < ApplicationRecord
  #クラス名（モデル名）を指定しないと
  #followersテーブルを参照しにいってしまうためエラーに
  belongs_to :follower, class_name: "User"
  #Userモデル内、フォローされる側と関連
  belongs_to :followed, class_name: "User"
  #Userモデル内、フォローする側と関連

  #１人のユーザーが１人に対して重複してフォローできないようバリデーション
  #validates :followed_id, uniqueness: {scope: :follower_id}？
  #
end
