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

  def fa_class_by_direction_order direction_order
    direction_order.present? && direction_order == 'asc' ? 'up' : 'down'
  end

  def time_expires_before_tomorrow? type_date, time
    type_date && time.present? && time <= DateTime.now.utc + 1.day
  end

  def category_tasks_direction_link_url category, city, direction_order
    new_order = order_direction_inverse(direction_order)
    if category.present?
      city.present? ? category_tasks_path(city_code: city.slug, order: new_order) : category_tasks_path(order: new_order)
    else
      city.present? ? tasks_path(city_code: city.slug, order: new_order) : tasks_path(order: new_order)
    end
  end

  def category_tasks_link_url category, city
    if category.present?
      city.present? ? category_tasks_path(city_code: city.slug) : category_tasks_path
    else
      city.present? ? city.slug + tasks_path : tasks_path
    end
  end
end
