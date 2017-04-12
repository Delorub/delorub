ActiveAdmin.register HelpCategory, namespace: :admin do
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false

  reorderable

  permit_params :title, :position

  index download_links: false, as: :reorderable_table do
    column(:title, sortable: false) do |item|
      link_to item.title, admin_help_category_help_answers_path(item)
    end
    actions
  end

  action_item :create, only: :show do
    link_to 'Добавить ответ', new_admin_help_category_help_answer_path(resource)
  end

  controller do
    def show
      redirect_to admin_help_category_help_answers_path(resource)
    end
  end
end
