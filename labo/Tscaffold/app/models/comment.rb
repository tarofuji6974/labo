class Comment < ApplicationRecord
  belongs_to :theme

  validates :comment, presence: true
end
