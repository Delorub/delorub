module ProfilesHelper
  def profiles_heading_categories
    return [] unless @category
    if @category.children_count && @category.children_count.positive?
      @category.children
    elsif @category.parent
      @category.parent.children
    else
      []
    end
  end
end
