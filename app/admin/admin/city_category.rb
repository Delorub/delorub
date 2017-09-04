ActiveAdmin.register_page 'CityCategory', namespace: :admin do
  menu parent: 'Настройки', priority: 2

  content do
    data = params[:data]
    @city = City.where(id: data[:city_id]).first if data
    selected_city = @city.present? ? @city : City.all.first
    settings_type = data ? data[:settings_type] : CityCategory.settings_type.values[0]
    render partial: 'settings', locals: { city: @city, selected_city: selected_city, settings_type: settings_type }
  end
end
