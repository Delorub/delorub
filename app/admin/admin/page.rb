ActiveAdmin.register Page, namespace: :admin do
  include ActiveAdminShared::ControllerRedirects

  permit_params :title, :content, :slug, :draft

  config.batch_actions = false

  filter :title

  index download_links: false do
    column(:title) { |page| link_to page.title, admin_page_path(page) }
    column :slug
    actions
  end

  form do |f|
    inputs 'Основное' do
      f.input :title
      f.input :slug
      f.input :content, as: :ckeditor
      f.input :draft
    end
    actions
  end

  action_item :view, only: :show do
    link_to 'На сайте', '/' + page.slug
  end

  show do
    h3 page.title
    div do
      simple_format page.content
    end
  end
end
