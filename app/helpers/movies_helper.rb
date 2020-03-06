module MoviesHelper
  def allow_review_deletion?(review)
    user_signed_in? && (current_user.id ==  review.user.id || current_user.admin)
  end

  def allow_posting_review(user, movie)
    if user.reviews.where(movie_id: movie.id).any?
      return false
    end
    return true
  end

  def favourite_movie?(movie)
    current_user.favourites.exists?(movie.id)
  end

end
