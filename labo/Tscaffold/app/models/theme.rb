class Theme < ApplicationRecord
  validates :theme, presence: true
  validates :url, presence: true, uniqueness: true
  belongs_to :user
  has_many :comment, dependent: :destroy
  
  def to_param
    url
  end
end
