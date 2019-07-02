class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_one_attached :thumbnail
  has_many_attached :posters
  has_one_attached :trailer
end
