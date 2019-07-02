class MoviesController < ApplicationController
  before_action :is_admin?

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
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_param)
      redirect_to movies_path
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movies_path
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private
  def movie_param
    params.require(:movie).permit(:title, :description)
  end

  def is_admin?
    if user_signed_in?
      if current_user && current_user.admin == true
        return true
      else
        redirect_to users_homepage_path
      end
    else
      redirect_to new_user_session_path
    end
  end

end
