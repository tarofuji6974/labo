class Theme < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comment, dependent: :destroy
  
  validates :theme, presence: true
  validates :url, presence: true, uniqueness: true

  
  def to_param
    url
  end
end
