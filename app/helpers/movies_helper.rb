module MoviesHelper
  def carousel_class(index)
    index == 0 && 'carousel-item active' || 'carousel-item'
  end

  def admin_logged_in?
    user_signed_in? && current_user.admin
  end
end
