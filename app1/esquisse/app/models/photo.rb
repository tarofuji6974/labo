class Photo < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites
  has_many :favorite_user, through: :favorites, source: :user

  validates :image_name, {presence: true}
end
