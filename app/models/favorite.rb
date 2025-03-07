class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: {scope: :book_id}
  #バリデーションとテーブルのUNIQUE制約
  #user_idについて、book_idとセットのすでに同じ値のペアがないか判定
end
