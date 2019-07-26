module HomeHelper
  def show_nav_item?(item1, item2)
    return 'active' if item1 && item1.none? && item2 && item2.none?
  end

  def show_tab_pane?(item1, item2)
     return 'active show' if item1 && item1.none? && item2 && item2.none?
  end
end
