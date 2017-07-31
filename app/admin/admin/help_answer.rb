ActiveAdmin.register HelpAnswer, namespace: :admin do
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false

  permit_params :title, :content, :synonyms, :help_category_id, :position

  actions :index, :new, :edit, :update, :create, :destroy

  reorderable

  belongs_to :help_category
  navigation_menu :default
  menu false

  index download_links: false, as: :reorderable_table do
    column(:title) do |item|
      link_to item.title, edit_admin_help_category_help_answer_path(item.help_category, item)
    end
    actions
  end

  form do |f|
    f.inputs 'Основное' do
      input :help_category
      input :title
      input :content
      input :synonyms
    end
    actions
  end
end
