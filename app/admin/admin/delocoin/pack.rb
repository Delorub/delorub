ActiveAdmin.register Delocoin::Pack, namespace: :admin do
  decorate_with Delocoin::PackDecorator

  config.sort_order = 'number_asc'

  permit_params :cost, :discount

  config.paginate = false

  index download_links: false do
    column :number
    column :cost
    column :discount
    actions
  end

  form do |f|
    inputs 'Основное' do
      input :cost
      input :discount
    end
    actions
  end
end
