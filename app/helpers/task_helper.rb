module TaskHelper
  def heading_categories
    if @category
      @category.children
    else
      Category.roots
    end
  end

  def order_direction_inverse(direction_order)
    direction_order.present? && direction_order == 'asc' ? 'desc' : 'asc'
  end
end
