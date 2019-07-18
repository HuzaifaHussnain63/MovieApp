class Review < ApplicationRecord
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user_id, uniqueness: { scope: :movie_id }

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

    if @movie.rating.nil?
      @movie.rating = 0.0
    end

    @movie.save
  end

  paginates_per 5
end
