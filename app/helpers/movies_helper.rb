module MoviesHelper
  def carousel_class(index)
    index == 0 && 'carousel-item active' || 'carousel-item'
  end

  def is_admin_signedin?
    return true if user_signed_in? && current_user.admin
    return false
  end
end
