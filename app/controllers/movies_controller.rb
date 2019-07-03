class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_param)
    if @movie.save
      redirect_to movie_path(@movie)
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
        redirect_to movie_path(@movie)
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
        redirect_to home_homepage_path
      else
        flash[:danger] = "Could not delete the movie"
        render home_homepage_path
      end
    else
      flash[:danger] = "No movie found with this id"
      redirect_to home_homepage_path
    end
  end

  def show
    if Movie.exists?(params[:id])
      @movie = Movie.find(params[:id])
    else
      flash[:danger] = "No movie found with this id"
      redirect_to home_homepage_path
    end
  end

  private
  def movie_param
    params.require(:movie).permit(:title, :description, :release_date, :genre, :thumbnail, :trailer, posters: [])
  end

end
