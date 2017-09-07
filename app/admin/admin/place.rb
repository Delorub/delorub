ActiveAdmin.register Place, namespace: :admin do
  actions :index, :show

  filter :by_search_in, label: 'Поиск', as: :string

  index do
    selectable_column
    column :name do |place|
      text_node link_to place.display_name, admin_place_path(place)
      if place.parent_place
        br
        small place.parent_place.full_name
      end
    end
    column :place_type_name do |place|
      small place.place_type_name.full_name
    end
  end

  collection_action :change_category_settings, method: :post do
    city = Place.only_cities.find(params[:city_id])
    if city.present?
      city_setting = city.categories_settings.where(category_id: params[:category_id],
                                                    settings_type: params[:settings_type]).first
      if city_setting.blank?
        city_setting = city.categories_settings.create(category_id: params[:category_id], settings_type: params[:settings_type])
      end
      city_setting.settings = RecursiveOpenStruct.new(params[:settings], recurse_over_arrays: true)
      city_setting.save
    end
    respond_to do |format|
      format.html { redirect_to admin_categoriessetting_path }
      format.json { render json: { result: true } }
    end
  end

  form do |f|
    inputs 'Основное' do
      input :name
    end
    actions
  end

  show do
    h3 place.name
    attributes_table_for place do
      row :fias_aoguid
      row :name
      row :full_name
      row :place_type_text
      if place.place_type_name
        row :place_type_name do |place|
          place.place_type_name.full_name
        end
      end
      row :parent_place
      row :region_place
      row :level
      row :search_string
    end
  end
end
