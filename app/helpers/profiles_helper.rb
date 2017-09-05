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

  def formatted_header_category category, city_settings = nil
    city_settings && city_settings.settings.dig(:h1).present? ? city_settings.settings.dig(:h1) : category.title
  end

  def formatted_header_category_or_city category, city, city_settings = nil
    "#{category.present? ? format(' в категории "%s"', formatted_header_category(category, city_settings)) : ''}
     #{city.present? ? format(' в городе %s', city.name) : ''}"
  end

  def category_profile_link_url category, city
    if category.present?
      city.present? ? category_profiles_path(city_code: city.code) : category_profiles_path
    else
      city.present? ? profiles_path(city_code: city.code) : profiles_path
    end
  end
end
