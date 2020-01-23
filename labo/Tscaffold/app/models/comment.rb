class Comment < ApplicationRecord
  #belongs_to :user
  belongs_to :theme, optional: true

  validates :comment, presence: true
end
