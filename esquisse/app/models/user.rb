class User < ApplicationRecord
  #パスワード暗号化の有効化
  has_secure_password

  #nameカラムに関するバリデーション
  #未入力不可/ユニーク名のみ
  validates :name,{presence: true,
    uniqueness: true}

  #passwordに関するバリデーション
  #未入力不可
  #validates :password,{presence: true}
end
