class Photo < ApplicationRecord
  belongs_to :user, optional: true
  #削除した時、依存関係にあるfavoritesも同時に削除される
  has_many :favorites, dependent: :destroy
  has_many :favorite_user, through: :favorites, source: :user

  validates :image_name, {presence: true}
end
