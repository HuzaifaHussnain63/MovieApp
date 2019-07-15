module MoviesHelper
  def carousel_class(index)
    index == 0 && 'carousel-item active' || 'carousel-item'
  end


  def allow_review_deletion?(review)
    user_signed_in? && (current_user.id ==  review.user.id || current_user.admin)
  end

  def allow_posting_review(user, movie)
    if user.reviews.where(movie_id: movie.id).any?
      return false
    end
    return true
  end

end
