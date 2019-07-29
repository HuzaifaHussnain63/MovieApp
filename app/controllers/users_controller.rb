class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :allow_adding_removing_favourite?, only: [:add_favourite, :remove_favourite]
  before_action :set_movie, only: [:add_favourite]

  def profile
    @favourite_movies = @user.favourites
  end

  def add_favourite
    if current_user.favourites << @movie
      flash[:notice] = 'You have added this movie to your favourites.'
    else
      flash[:danger] = 'Could not add this movie to your favourites.'
    end
  end

  def remove_favourite
    if current_user.favourites.exists?(params[:movie_id])
      @movie = current_user.favourites.find(params[:movie_id])
      current_user.favourites.delete(@movie)
      flash[:notice] = 'You have removed this movie form your favourites.'
    else
      flash[:danger] = 'Could not remove this movie form your favourites.'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def allow_adding_removing_favourite?
    @user.id == current_user.id
  end
end
