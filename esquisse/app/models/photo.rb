class Photo < ApplicationRecord
  belongs_to :user, optional: true

  #画像名：未入力不可
  validates :image_name,{presence: true}
end
