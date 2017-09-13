ActiveAdmin.register Category, namespace: :admin do
  config.sort_order = 'position_asc'
  config.paginate = false

  permit_params :title, :parent_id, :photo, :description, :is_main

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

  sidebar 'Изображение', only: :show, if: proc{ !category.photo.file.nil? } do
    img src: category.photo.thumb.url
  end

  sidebar 'Статистика', only: :show do
    attributes_table_for category do
      row :master_count
      row :form_count
    end
  end

  controller do
    def create
      super do |format|
        redirect_to collection_path and return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to collection_path and return if resource.valid?
      end
    end
  end
end
