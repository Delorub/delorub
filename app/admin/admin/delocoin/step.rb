ActiveAdmin.register Delocoin::Step, namespace: :admin do
  permit_params :rate, :date_from, :is_current

  config.paginate = false

  index download_links: false do
    column :id
    column :date_from
    column :rate
    column :is_current
    actions
  end
end
