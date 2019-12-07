class Photo < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_user, through: :favorites, source: :user
end
