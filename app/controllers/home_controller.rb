class HomeController < ApplicationController

  def index
    @movies = Movie.all
    render 'firstpage.html.erb'
  end

end
