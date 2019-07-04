module MoviesHelper
  def carousel_class(index)
    index == 0 && 'carousel-item active' || 'carousel-item'
  end
end
