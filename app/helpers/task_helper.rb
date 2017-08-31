module TaskHelper
  def heading_categories
    if @category
      @category.children
    else
      Category.roots
    end
  end

  def order_direction_inverse direction_order
    direction_order.present? && direction_order == 'asc' ? 'desc' : 'asc'
  end

  def time_expires_before_tomorrow? type_date, time
    type_date && time.present? && time <= (DateTime.now.getlocal + 1.day).to_s(:db).to_datetime
  end
end
