ActiveAdmin.register PlaceCategoriesSettings do
  menu false

  collection_action :export, method: :get do
    export = PlaceCategorySettings::ExportService.new(city: city, type: params[:type], category: category)

    send_data export.perform, type: 'application/xlsx', filename: export.name
  end

  collection_action :import, method: :post do
    begin
      PlaceCategorySettings::ImportService.new(file: params[:file], city: city, type: params[:type], category: category).perform
    rescue StandardError => error
      flash[:error] = error.message
    end

    redirect_to admin_seosettings_path(city_id: city.id, category_id: category.id, settings_type: params[:type])
  end

  collection_action :change_category_settings, method: :put do
    if city.present?
      setting = find_category_setting
      setting.settings = RecursiveOpenStruct.new(params[:settings], recurse_over_arrays: true)
      setting.save
    end

    respond_to do |format|
      format.html { redirect_to admin_seosettings_path }
      format.json { render json: { result: true } }
    end
  end

  controller do
    helper_method :city, :category

    private

      def city
        @city = Place.only_cities.find(params[:city_id])
      end

      def category
        @category = Category.roots.find(params[:category_id])
      end

      def find_category_setting
        setting = city.categories_settings.where(category_id: params[:category_id], settings_type: params[:settings_type]).first
        if setting.blank?
          setting = city.categories_settings.create(category_id: params[:category_id], settings_type: params[:settings_type])
        end
        setting
      end
  end
end
