ActiveAdmin.register News, namespace: :admin do
  permit_params :title, :created_at, :content, :photo

  filter :title
  filter :created_at

  index download_links: false do
    selectable_column
    column(:title) { |news| link_to news.title, admin_news_path(news) }
    column :created_at
  end

  form do |f|
    f.inputs 'Основное' do
      input :title
      input :content
      input :photo
    end
    actions
  end

  show do
    h3 news.title
    div do
      simple_format news.content
    end
  end

  sidebar 'Информация', only: :show do
    attributes_table_for news do
      row :created_at
      row :updated_at
    end
  end
end
