class HomeController < ApplicationController

  def index
    @top_movies = Movie.where("rating > ?", 4.5)
    @upcoming = Movie.where("release_date > ?", Date.today)
    @latest = Movie.where("release_date BETWEEN ? AND ?", Date.today - 6.months, Date.today)
    @genres = Movie.all.distinct.pluck(:genre)
    @genres.prepend("Genre")
  end

end
