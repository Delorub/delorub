ActiveAdmin.register City, namespace: :admin do
  menu parent: 'Настройки', priority: 1

  permit_params :name, :code, :active

  filter :name
  filter :code
  filter :active

  collection_action :change_settings, method: :post do
    city = City.find(params[:city_id])
    if city.present?
      city_setting = city.city_categories.where(category_id: params[:category_id], settings_type: params[:settings_type]).first
      if city_setting.blank?
        city_setting = city.city_categories.create(category_id: params[:category_id], settings_type: params[:settings_type])
      end
      city_setting.settings = RecursiveOpenStruct.new(params[:settings], recurse_over_arrays: true)
      city_setting.save
    end
    respond_to do |format|
      format.html { redirect_to admin_citycategory_path }
      format.json { render json: { result: true } }
    end
  end

  index download_links: false do
    selectable_column
    column(:name) { |city| link_to city.name, admin_cities_path(city) }
    column :code
    column :active
    column :created_at
    actions
  end

  form do |f|
    inputs 'Данные' do
      f.input :name
      f.input :code
      f.input :active
    end
    actions
  end

  controller do
    def create
      super do |format|
        redirect_to collection_path && return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to collection_path && return if resource.valid?
      end
    end
  end
end
