class ReportReviewsController < ApplicationController
  before_action :set_review, only: [:report, :delete_complaint]
  before_action :authenticate_admin, except: [:report]

  def report
    if @review
      if ReportedReview.new(review_id: @review.id, user_id: current_user.id, movie_id: @review.movie_id).save
        flash[:notice] = 'You have successfully reported the review'
      else
        flash[:danger] = 'Could not report the review.'
        render 'shared/_display_flash' # this will show the error
      end
    end
  end

  def index
    @reported_reviews = ReportedReview.includes(:user, review: [:user])
  end

  def delete_complaint
    ReportedReview.where(review_id: @review.id).destroy_all
    flash[:notice] = 'You have deleted the complaint'
    redirect_to reported_reviews_path
  end

  def delete_all_complaints
    ReportedReview.destroy_all
    flash[:notice] = 'Successfully deleted all complaints'
    redirect_to reported_reviews_path
  end

end
