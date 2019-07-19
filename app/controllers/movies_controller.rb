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
    @actors_not_in_movie = Actor.where.not(id: ActorsMovie.where(movie_id: @movie.id).pluck(:actor_id)).map { |actor| [actor.name, actor.id] }
    @review = Review.new
    if user_signed_in?
      @reviews_reported_by_user = ReportedReview.where(user_id: current_user.id, movie_id: @movie.id).pluck(:review_id)
    else
      @reviews_reported_by_user = []
    end
    @reviews = @movie.reviews.includes(:user).order(created_at: :desc).page params[:page]
  end

  def detach_actor
    if @movie.actors.delete(@actor)
      flash[:notice] = 'Successfully removed the actor from the movie'
    else
      flash[:danger] = 'Could not remove the actor'
    end

    redirect_to movie_path(@movie)
  end

  # this action will add actor to movie cast
  def attach_actor
    if @movie.actors << @actor
      flash[:notice] = 'Successfully added the actor to the movie'
    else
      flash[:danger] = 'Could not add the actor'
    end

    redirect_to movie_path(@movie)
  end

  def add_trailer
    @trailer = params[:adding_trailer][:trailer]

    if @trailer.content_type.include?('video')
      @movie.trailer.attach(params[:adding_trailer][:trailer])
      flash[:notice] = 'Successfully added trailer for the movie.'
    else
      flash["danger"] = 'Could not add trailer. Format for the trailer is not correct.'
    end

    redirect_to movie_path(@movie)
  end

  # this action will detach trailer from a movie
  def remove_trailer
    @movie.trailer.purge
    redirect_to movie_path(@movie)
  end

  def remove_poster
    @movie.posters.find(params[:poster_id]).purge
    redirect_to movie_path(@movie)
  end

  def add_poster
    @poster = params[:adding_poster][:posters]
    if @poster.content_type.include?('image')
      @movie.posters.attach(params[:adding_poster][:posters])
      flash[:notice] = 'Successfully added poster for the movie'
    else
      flash[:danger] = 'Could not add poster. Format for the poster is invalid'
    end

    redirect_to movie_path(@movie)
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

end
