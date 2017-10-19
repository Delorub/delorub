ActiveAdmin.register Delocoin::Pack, namespace: :admin do
  decorate_with Delocoin::PackDecorator

  config.sort_order = 'number_asc'

  permit_params :cost, :discount, :is_public

  config.paginate = false

  index download_links: false do
    column :number
    column :cost
    column :discount
    column :is_public
    actions
  end

  form do |f|
    inputs 'Основное' do
      input :cost
      input :discount
      input :is_public
    end
    actions
  end
end
