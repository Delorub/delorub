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
    type_date && time.present? && time <= DateTime.now.utc + 1.day
  end

  def category_task_link_url category, city, direction_order
    new_order = order_direction_inverse(direction_order)
    if category.present?
      city.present? ? category_tasks_path(city_code: city.slug, order: new_order) : category_tasks_path(order: new_order)
    else
      city.present? ? tasks_path(city_code: city.slug, order: new_order) : tasks_path(order: new_order)
    end
  end

  def parse_city_settings settings, key, default_value = ''
    settings.present? && settings.settings.dig(key).present? ? settings.settings.dig(key) : default_value
  end
end
