class Event < ApplicationRecord
  attribute :url_token, :string, default: SecureRandom.hex(10)
  #validates :title, presence: true
  #validates :candidate_date, presence: true
  #validates :url, presence: true, uniqueness: true

  def to_param
    url
  end
end
