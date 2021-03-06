ActiveAdmin.register Vacancy, namespace: :admin do
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false

  permit_params :title, :small_description, :description, :archive

  reorderable

  index download_links: false, as: :reorderable_table do
    column(:title) do |item|
      link_to item.title, resource_path(item)
    end
  end

  form do |f|
    f.inputs 'Основное' do
      input :title
      input :small_description
      input :description
      input :archive
    end
    actions
  end
end
