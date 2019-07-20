class MoviesController < ApplicationController
  before_action :authenticate_admin, except: [:show, :search_movie]
  before_action :set_movie, except: [:new, :create, :index, :search_movie]
  before_action :set_actor, only: [:detach_actor, :attach_actor]

  def index
    @movies = Movie.order(release_date: :desc).page params[:page]
  end

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
  end

  def update
    if @movie.update(movie_param)
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  def destroy
    if @movie.destroy
      redirect_to home_index_path
    else
      flash[:danger] = 'Could not delete the movie'
      redirect_to home_index_path
    end
  end

  def show
    actors_not_in_movie
    @review = Review.new
    if user_signed_in?
      @reviews_reported_by_user = ReportedReview.where(user_id: current_user.id, movie_id: @movie.id).pluck(:review_id)
    else
      @reviews_reported_by_user = []
    end
    @reviews = @movie.reviews.includes(:user).order(created_at: :desc).page params[:page]
  end

  def detach_actor
    unless @movie.actors.delete(@actor)
      flash[:danger] = 'Could not remove the actor'
      render 'reviews/create_error'
    end
    actors_not_in_movie
    render
  end

  # this action will add actor to movie cast
  def attach_actor
    if @movie.actors.include? @actor
      flash[:danger] = 'Could not add the actor'
      render 'reviews/create_error'
    else
      @movie.actors << @actor
    end
    actors_not_in_movie
  end

  def add_trailer
    if params[:adding_trailer]
      @trailer = params[:adding_trailer][:trailer]

      if @trailer.content_type.include?('video')
        @movie.trailer.attach(params[:adding_trailer][:trailer])
        set_movie # getting the upated movie object
        render 'add_remove_trailer'
      else
        flash["danger"] = 'Could not add trailer. Format for the trailer is not correct.'
        render 'reviews/create_error'
      end

    else
      flash[:danger] = 'Please select a trailer'
      render 'reviews/create_error'
    end

  end

  # this action will detach trailer from a movie
  def remove_trailer
    if @movie.trailer.attached?
      @movie.trailer.purge
      set_movie
      render 'add_remove_trailer' # it will check if trailer exist, and if trailer does not exit it will make appropriate changes in the html
    else
      flash[:danger] = 'Movie has no trailer to remove.'
      render 'reviews/create_error'
    end
  end

  def remove_poster
    @movie.posters.find(params[:poster_id]).purge
  end

  def add_poster
    if params[:adding_poster]
      @poster = params[:adding_poster][:posters]

      if @poster.content_type.include?('image')
        @movie.posters.attach(params[:adding_poster][:posters])
        # to get the id of just added poster i m doing this:
        @added_poster = @movie.posters.last
      else
        flash[:danger] = 'Could not add poster. Format for the poster is invalid'
        render 'reviews/create_error'
      end
    else
      flash[:danger] = 'Please select a poster'
      render 'reviews/create_error'
    end
  end

  def search_movie
    if params[:search_text] != ''
      if params[:genre] == 'Genre'
        @result = Movie.where('title LIKE ?', "%#{params[:search_text]}%").limit(5).page params[:page]
      else
        @result = Movie.where('title LIKE ? AND genre = ?', "%#{params[:search_text]}%", params[:genre]).limit(5).page params[:page]
      end
    else
      @result = []
    end
    @genres = Movie.all.distinct.pluck(:genre)
    @genres.prepend("Genre")
    respond_to do |format|
      format.js { render 'movie_search_response' }
      format.html { render }
    end
  end

  private
  def movie_param
    params.require(:movie).permit(:title, :description, :release_date, :genre, :thumbnail, :trailer, posters: [])
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def actors_not_in_movie
    @actors_not_in_movie = (Actor.all - @movie.actors).map { |actor| [actor.name, actor.id] }
  end

end
