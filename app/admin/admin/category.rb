ActiveAdmin.register Category, namespace: :admin do
  config.sort_order = 'position_asc'
  config.paginate = false

  permit_params :title, :parent_id, :photo

  filter :by_search_in, label: 'Поиск', as: :string

  reorderable

  index download_links: false, as: :reorderable_table do
    column(:title) do |category|
      link_to category.title, admin_category_path(category)
    end
  end

  form do |f|
    f.inputs 'Основное' do
      input :title
      input :parent, collection: nested_set_options_for_category(category)
      input :photo
    end
    actions
  end

  show do
    h3 category.title
    attributes_table_for category do
      row :title
      row :parent
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
end
