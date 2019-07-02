class HomeController < ApplicationController

  def homepage
    @movies = Movie.all
  end

end
