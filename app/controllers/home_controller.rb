class HomeController < ApplicationController

  def index
    @top_movies = Movie.where("rating > ?", 4.5).order(:rating).limit(12)
    @upcoming = Movie.where("release_date > ?", Date.today).order(:release_date).limit(12)
    @latest = Movie.where("release_date BETWEEN ? AND ?", Date.today - 6.months, Date.today).order(release_date: :desc).limit(8)
    @genres = Movie.all.distinct.pluck(:genre)
    @genres.prepend("Genre")
  end

end
