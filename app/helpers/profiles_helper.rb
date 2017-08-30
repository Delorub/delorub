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

  def order_direction_boolean direction_order
    direction_order.present? && direction_order.to_i == 1 ? true : false
  end

  def formatted_header_category category
    category.settings.dig(:h1).blank? ? category.title : category.settings.dig(:h1)
  end
end
