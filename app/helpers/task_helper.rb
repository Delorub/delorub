module TaskHelper
  def heading_categories
    if @category
      @category.children
    else
      Category.roots
    end
  end
end
