class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy]
  before_action :find_movie, only: [:update, :destroy, :create]
  before_action :allow_deletion?, only: [:destroy]
  after_action :set_review, only: [:update]
  before_action :set_reported_reviews_by_user, only: [:create, :update]

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = 'Successfully Posted the review.'
      find_movie
    else
      flash[:danger] = 'Could not post the review. Try again.'
      render 'shared/_display_flash'
    end

  end

  def destroy
    if @review.destroy
      flash[:notice] = 'Successfully deleted the review'
      find_movie
      respond_to do |format|
        format.js { render }
        format.html { redirect_to reported_reviews_path }
      end
    else
      flash[:danger] = 'Could not delete the review'
      render 'shared/_display_flash'
    end
  end

  def update
    if @review.update(review_params)
      flash[:notice] = 'Successfully updated the review.'
    else
      flash[:danger] = 'Could not update the review.'
      render 'shared/_display_flash'
    end
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
    if user_signed_in? && (current_user.id == @review.user.id || current_user.admin)
      return true
    else
      flash[:danger] = 'You cannot delete this review.'
      redirect_to movie_path(@movie)
    end
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

end
