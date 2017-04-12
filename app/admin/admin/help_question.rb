ActiveAdmin.register HelpQuestion, namespace: :admin do
  actions :index, :show, :destroy

  config.filters = false

  index download_links: false do
    column :name, sortable: false do |item|
      text_node item.name
      br
      small mail_to item.email
    end
    column :content, sortable: false do |item|
      truncate item.content, length: 100
    end
    column :created_at
    column :actions, defaults: false do

    end
  end
end
