module TaskHelper
  def heading_categories
    if @category
      @category.children
    else
      Category.roots
    end
  end

  def time_expires_before_tomorrow? type_date, time
    type_date && time.present? && time <= DateTime.now.utc + 1.day
  end

  def category_tasks_link_url category, city
    if category.present?
      city.present? ? category_tasks_path(category, city_code: city.slug) : category_tasks_path(category)
    else
      city.present? ? city.slug + tasks_path : tasks_path
    end
  end
end
