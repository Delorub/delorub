ActiveAdmin.register Delocoin::Pack, namespace: :admin do
  permit_params :cost, :discount

  config.paginate = false

  index download_links: false do
    column :cost
    column :discount
    actions
  end
end
