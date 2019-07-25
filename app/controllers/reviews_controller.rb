class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy]
  before_action :find_movie, only: [:update, :destroy, :create]
  before_action :allow_deletion?, only: [:destroy]

  def create
     @review = Review.new(review_params)
     set_reported_reviews_by_user(current_user.id, @movie.id)
     if @review.save
      flash[:notice] = 'Successfully Posted the review.'
      find_movie
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

  end

  def update
    set_reported_reviews_by_user(current_user.id, @review.movie_id)
    if @review.update(review_params)
      flash[:notice] = 'Successfully updated the review'
    else
      flash[:danger] = 'Could not update the review'
    end
    set_review
  end

  private
  def review_params
    if params[:reviewer_id]
      params.permit(:rating, :comment, :movie_id).merge!(user_id: params[:reviewer_id])
    else
      params.permit(:rating, :comment, :movie_id).merge!(user_id: current_user.id)
    end
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

  def set_reported_reviews_by_user(user_id, movie_id)
    @reviews_reported_by_user = ReportedReview.where(user_id: user_id, movie_id: movie_id).pluck(:review_id)
  end

end
