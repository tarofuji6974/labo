class User < ActiveRecord::Base

  has_secure_password
    # nameカラムに関するバリデーション
  validates :name,{presence: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true,
    uniqueness: true}

  # passwordカラムに関するバリデーション
  # validates :password,{presence: true}
end
