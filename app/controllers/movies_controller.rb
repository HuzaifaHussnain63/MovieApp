class MoviesController < ApplicationController
  before_action :authenticate_admin, except: [:show]

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
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_param)
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy()
      redirect_to home_index_path
    else
      flash[:danger] = "Could not delete the movie"
      redirect_to home_index_path
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @actors_not_in_movie =  Actor.all.where.not(id: Movie.find(params[:id]).actors)
  end

  def remove_actor
    @movie = Movie.find(params[:id])
    @actor = Actor.find(params[:actor_id])
    @movie.actors.delete(@actor)
    redirect_to movie_path(@movie)
  end

  # this action will add actor to movie cast
  def add_actor
    @movie = Movie.find(params[:movie_id])
    @actor = Actor.find(params[:actor][:id])
    @movie.actors << @actor
    redirect_to movie_path(@movie)
  end

  def add_trailer
    @movie = Movie.find(params[:movie_id])
    @movie.trailer.attach(params[:adding_trailer][:trailer])
    redirect_to movie_path(@movie)
  end

  # this action will detach trailer from a movie
  def remove_trailer
    @movie = Movie.find(params[:id])
    @movie.trailer.delete
    redirect_to movie_path(@movie)
  end

  def remove_poster
    @movie = Movie.find(params[:id])
    @movie.posters.find(params[:poster_id]).purge
    redirect_to movie_path(@movie)
  end

  def add_poster
    @movie = Movie.find(params[:movie_id])
    @movie.posters.attach(params[:adding_poster][:posters])
    redirect_to movie_path(@movie)
  end

  private
  def movie_param
    params.require(:movie).permit(:title, :description, :release_date, :genre, :thumbnail, :trailer, posters: [])
  end

  def authenticate_admin
    return true if user_signed_in? && current_user.admin?
    flash[:alert] = "You need to be admin to access this section"
    redirect_to home_index_path
  end

end
