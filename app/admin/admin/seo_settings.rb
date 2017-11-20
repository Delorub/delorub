ActiveAdmin.register_page 'SeoSettings', namespace: :admin do
  content do
    render partial: 'settings',
           locals: { cities: cities,
                     categories: categories,
                     selected_city: selected_city,
                     selected_type: selected_type,
                     selected_category: selected_category }
  end

  controller do
    helper_method :cities, :categories, :selected_city, :selected_category, :selected_type

    def cities
      @cities = Place.only_cities.order(:name)
    end

    def categories
      @categories = Category.roots.except(:order).order(:title)
    end

    def selected_city
      params[:city_id] ? cities.find(params[:city_id]) : cities.first
    end

    def selected_type
      params[:settings_type] ? params[:settings_type] : PlaceCategoriesSettings.settings_type.values[0]
    end

    def selected_category
      params[:category_id] ? categories.find(params[:category_id]) : categories.first
    end
  end
end
