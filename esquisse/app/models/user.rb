class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :photo,dependent: :destroy
  
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
