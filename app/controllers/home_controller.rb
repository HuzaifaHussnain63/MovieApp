class HomeController < ApplicationController

  def firstpage
    @movies = Movie.all
  end

end
