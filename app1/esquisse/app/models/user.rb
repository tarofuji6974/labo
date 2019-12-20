class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #アソシエーション
  has_many :photos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_photo, through: :favorites, source: :photo

  #nameを入力必須カラムにする
  validates :name, presence: true

  def already_fav?(photo)
    self.favorites.exists?(photo_id: photo.id)
  end
end
