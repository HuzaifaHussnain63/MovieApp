module MoviesHelper
  def carousel_class(index)
    if index == 0
      return 'carousel-item active'
    else
      return 'carousel-item'
    end
  end
end
