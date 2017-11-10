ActiveAdmin.register ExternalData::VkAccount, namespace: :admin do
  config.sort_order = 'id_desc'

  permit_params :login, :password

  index download_links: false do
    selectable_column
    column :login
    column :password
    column :state
    actions
  end

  form do |f|
    f.inputs 'Данные для входа' do
      input :login
      input :password
    end
    actions
  end
end
