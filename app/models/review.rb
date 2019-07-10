class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  belongs_to :movie
  belongs_to :user

  paginates_per 5
end
