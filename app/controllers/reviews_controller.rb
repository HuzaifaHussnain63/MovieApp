class ReviewsController < ApplicationController
  before_action :allow_deletion?, only: [:destroy]
  before_action :set_review, only: [:update, :destroy]
  before_action :find_movie, only: [:update, :destroy, :create]

  def create
     @review = Review.new(review_params)
     @reviews_reported_by_user = ReportedReview.where(user_id: current_user.id, movie_id: @movie.id).pluck(:review_id)

     if @review.save
      flash[:notice] = 'Successfully Posted the review.'
      respond_to do |format|
        format.js { render }
      end
    else
      flash[:danger] = 'Could not post the review. Try again.'
      respond_to do |format|
        format.js { render 'create_error' }
      end
    end

  end

  def destroy
    if @review.destroy
      flash[:notice] = 'Successfully deleted the review'
    else
      flash[:danger] = 'Could not delete the review'
    end
    redirect_to movie_path(@movie)
  end

  def update
    if @review.update(review_params)
      flash[:notice] = 'Successfully updated the review'
    else
      flash[:danger] = 'Could not update the review'
    end
    redirect_to movie_path(@movie)
  end

  private
  def review_params
    params.permit(:rating, :comment, :movie_id).merge!(user_id: current_user.id)
  end

  def allow_deletion?
    @review = Review.find(params[:id])

    if user_signed_in? && (current_user.id == @review.user.id || current_user.admin)
      return true
    else
      flash[:danger] = 'You cannot delete this review.'
      redirect_to movie_path(Movie.find(@review.movie_id))
    end

  end

  def set_review
    @review = Review.find(params[:id])
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

end
