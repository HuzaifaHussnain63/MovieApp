class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def profile
    @favourite_movies = @user.favourites
  end

  def add_favourite
    @movie = Movie.find(params[:movie_id])
    if current_user.favourites << @movie
      flash[:notice] = 'You have added this movie to your favourites.'
    else
      flash[:danger] = 'Could not add this movie to your favourites.'
    end
    redirect_back(fallback_location: home_index_path)
  end

  def remove_favourite
    if current_user.favourites.exists?(params[:movie_id])
      @movie = current_user.favourites.find(params[:movie_id])
      current_user.favourites.delete(@movie)
      flash[:notice] = 'You have removed this movie form your favourites.'
    else
      flash[:danger] = 'Could not remove this movie form your favourites.'
    end
    redirect_back(fallback_location: home_index_path)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
