class MoviesController < ApplicationController

  before_action :require_login

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_param)
    if @movie.save
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def edit

    if Movie.exists?(params[:id])
      @movie = Movie.find(params[:id])
    else
      flash[:danger] = "No movie found with this id"
      redirect_to home_homepage_path
    end

  end

  def update
    if Movie.exists?(params[:id])
      @movie = Movie.find(params[:id])
      if @movie.update(movie_param)
        redirect_to movies_path
      else
        render 'edit'
      end
    else
      flash[:danger] = "No movie found with this id"
      redirect_to home_homepage_path
    end
  end

  def destroy
    if Movie.exists?(params[:id])
      @movie = Movie.find(params[:id])
      if @movie.destroy()
        redirect_to movies_path
      else
        flash[:danger] = "Could not delete the movie"
        render movies_path
      end
    else
      flash[:danger] = "No movie found with this id"
      redirect_to home_homepage_path
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private
  def movie_param
    params.require(:movie).permit(:title, :description)
  end

  def require_login
    if user_signed_in?
      return true
    else
      flash[:error] = "You must be logged in to access this section."
      redirect_to new_user_session_path
    end
  end

end
