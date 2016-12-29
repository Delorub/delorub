ActiveAdmin.register Page do
  permit_params :title, :content, :slug
  
  config.batch_actions = false
  
  filter :title

  index download_links: false do
    column(:title) { |page| link_to "#{page.title}", admin_page_path(page) }
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
