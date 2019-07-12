class ReportReviewsController < ApplicationController
  before_action :set_review, only: [:report, :delete_reported_review]

  def report
    if @review
      if ReportedReview.new(review_id: @review.id, user_id: current_user.id, movie_id: @review.movie_id).save
        flash[:notice] = 'You have successfully reported the review'
      else
        flash[:danger] = 'Could not report the review.'
      end
      redirect_to movie_path(@review.movie.id)
    end
    byebug
  end

  def index
  end

  def delete_reported_review
  end

  private
  def set_review
    @review = Review.find(params[:id])
  end

end
