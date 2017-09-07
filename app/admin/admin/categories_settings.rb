ActiveAdmin.register_page 'CategoriesSettings', namespace: :admin do
  content do
    data = params[:data]
    @city = Place.only_cities.where(id: data[:city_id]).first if data
    selected_city = @city.present? ? @city : Place.only_cities.first
    settings_type = data ? data[:settings_type] : PlaceCategoriesSettings.settings_type.values[0]
    render partial: 'settings', locals: { city: @city, selected_city: selected_city, settings_type: settings_type }
  end
end
