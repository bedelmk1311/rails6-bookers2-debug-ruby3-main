class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  #クラス名（モデル名）を指定しないと
  #followersテーブルを参照しにいってしまうためエラーに

  #１人のユーザーが１人に対して重複してフォローできないようバリデーション
  #validates :followed_id, uniqueness: {scope: :follower_id}？
  #
end
