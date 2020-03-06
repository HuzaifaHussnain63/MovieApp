class Api::MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:actors, reviews: [:user]).where('title LIKE ?', "%#{params[:title]}%").page params[:page]
    render json: @movies
  end
end
