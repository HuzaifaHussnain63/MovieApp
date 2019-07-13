class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  belongs_to :movie
  belongs_to :user
  has_many :reported_reviews, dependent: :destroy

  after_save do |instance|
    @movie = Movie.find(instance.movie_id)
    @movie.rating = @movie.reviews.average(:rating)
    @movie.save
  end

  after_destroy do |instance|
    @movie = Movie.find(instance.movie_id)
    @movie.rating = @movie.reviews.average(:rating)
    @movie.save
  end

  paginates_per 5
end
