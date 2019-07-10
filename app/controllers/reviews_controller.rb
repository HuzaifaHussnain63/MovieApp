class ReviewsController < ApplicationController
  before_action :allow_deletion?, only: [:destroy]

  def create
     @review = Review.new(review_params)
     if @review.save
      respond_to do |format|
        format.js { render layout: false }
      end
    else
      flash[:danger] = 'Could not post the review. Try again.'
      respond_to do |format|
        format.js { render 'create_error', layout: false }
      end
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    if @review.destroy
      redirect_to movie_path(@movie)
    else
      flash[:danger] = 'Could not delete the review'
      redirect_to movie_path(@movie)
    end
  end

  def update
  end

  private
  def review_params
    params.permit(:rating, :comment, :movie_id).merge!(user_id: current_user.id)
  end

  def allow_deletion?
    @review = Review.find(params[:id])
    user_signed_in? && (current_user.id ==  @review.user.id || current_user.admin)
  end
end
