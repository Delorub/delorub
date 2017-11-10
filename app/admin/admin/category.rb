ActiveAdmin.register Category, namespace: :admin do
  include ActiveAdminShared::ControllerRedirects

  config.sort_order = 'position_asc'
  config.paginate = false

  permit_params :title, :parent_id, :photo, :description, :is_main, :position

  filter :by_search_in, label: 'Поиск', as: :string
  filter :category_id

  index download_links: false do
    column :title
    column :slug
    column :is_main
    column :position
    column '' do |cat|
      link_to 'Настройки', settings_admin_category_path(cat)
    end
    actions
  end

  action_item :settings, only: :show do
    link_to 'Настройки', settings_admin_category_path(category)
  end

  action_item :import_external_data, only: :index do
    link_to 'Импортировать слова', import_external_data_admin_categories_path
  end

  action_item :export_external_data, only: :index do
    link_to 'Экспортировать слова', export_external_data_admin_categories_path
  end

  member_action :settings, method: [:get, :put] do
    @form = ActiveAdmin::CategorySettingsForm.new resource
    @form.prepopulate!
    if request.put?
      if @form.validate params.require(:category).permit!
        @form.save do |hash|
          resource.settings = RecursiveOpenStruct.new(hash[:settings], recurse_over_arrays: true)
          resource.settings.price_ranges.reject! { |e| e.title.blank? }
          resource.settings.price_ranges.sort_by! { |e| e.price.to_i }
          return redirect_to settings_admin_category_path(resource), notice: 'Настройки обновлены' if resource.save
        end
      end
    end
  end

  form do |f|
    inputs 'Основное' do
      f.input :title
      f.input :position
      f.input :parent, collection: Category.roots.map{ |a| [a.title, a.id] }
      f.input :photo
      f.input :is_main
      f.input :description
    end
    f.inputs 'Настройки' do
      fields_for :settings do |s|
        s.fields_for :price_ranges do |pr|
          pr.input :ds
        end
      end
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :parent
      row :is_main
      row :slug
      row :description
      row :created_at
      row :updated_at
    end

    panel 'Слова' do
      attributes_table_for category.external_data_settings do
        row :words do |external_data_settings|
          if external_data_settings.words.present?
            text_node external_data_settings.words.join ', '
          end
        end
        row :stopwords do |external_data_settings|
          if external_data_settings.stopwords.present?
            text_node external_data_settings.stopwords.join ', '
          end
        end
      end
    end
  end

  sidebar 'Изображение', only: :show, if: proc{ !category.photo.file.nil? } do
    img src: category.photo.thumb.url
  end

  sidebar 'Статистика', only: :show do
    attributes_table_for category do
      row :master_count
      row :form_count
    end
  end

  collection_action :import_external_data, method: [:get, :put] do
    return if request.get?

    Category::ExternalDataSettings::Import.new(params[:file]).perform

    redirect_to admin_categories_path, notice: 'Импорт слов выполнен'
  end

  collection_action :export_external_data, method: :get do
    service = Category::ExternalDataSettings::Export.new
    service.perform
    send_data service.contents, filename: 'category_words_export.xlsx', type: 'application/xslx'
  end
end
