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

  def category_city_profile_link_url category, city
    if category.present?
      city.present? ? category_profiles_path(category, city_code: city.slug) : category_profiles_path(category)
    else
      url_for(controller: 'profiles', action: 'index', city_code: city.present? ? city.slug : nil)
    end
  end

  def category_profile_link_url category
    category.present? ? category_profiles_path(category) : profiles_path
  end
end
