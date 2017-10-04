ActiveAdmin.register ExternalData, namespace: :admin do
  config.sort_order = 'id_desc'

  config.paginate = true
  config.filters = false

  scope :available, default: true do |external_data|
    external_data.parser_approved.where(state: 'new')
  end

  scope :approved
  scope :rejected

  scope :parser_approved
  scope :parser_rejected

  index download_links: false do
    column :text do |external_data|
      ExternalData::Presenter.for(external_data).text
    end
    column :source do |external_data|
      link_to ExternalData::Presenter.for(external_data).url, ExternalData::Presenter.for(external_data).url, target: '_blank'
    end
    actions defaults: false do |external_data|
      item 'Approve', admin_external_data_path(external_data)
      text_node ' '
      item 'Reject', admin_external_data_path(external_data)
      text_node ' '
      item 'View', admin_external_data_path(external_data)
    end
  end

  action_item :delete_all, only: :index do
    link_to 'Удалить все данные', delete_all_admin_external_data_path
  end

  member_action :approve, method: :get do
    resource.approve!
    redirect_to admin_external_data_path
  end

  member_action :reject, method: :get do
    resource.reject!
    redirect_to admin_external_data_path
  end

  collection_action :delete_all, method: :get do
    ExternalData.delete_all

    redirect_to admin_external_data_path, notice: 'Записи удалены'
  end
end
