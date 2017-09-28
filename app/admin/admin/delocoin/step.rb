ActiveAdmin.register Delocoin::Step, namespace: :admin do
  decorate_with Delocoin::StepDecorator

  config.sort_order = 'number_asc'

  permit_params :rate, :date_from

  config.paginate = false

  index download_links: false do
    column :number
    column :date_from
    column :rate
    column :is_current
    actions
  end

  form do |f|
    inputs 'Основное' do
      input :date_from
      input :rate
    end
    actions
  end
end
