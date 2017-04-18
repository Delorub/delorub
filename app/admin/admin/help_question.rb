ActiveAdmin.register HelpQuestion, namespace: :admin do
  actions :index, :show, :destroy

  config.filters = false

  member_action :reply, method: [:get, :put] do
    if request.put?
      resource.attributes = params[:help_question].permit(:reply)
      if resource.save
        redirect_to resource_path, notice: 'Ответ отправлен!'
      end
    end
  end

  action_item :view, only: :show do
    link_to 'Ответить', reply_admin_help_question_path(help_question)
  end

  show do
    panel "Вопрос #{help_question.display_name}" do
      attributes_table_for help_question do
        row :name
        row :email
        row :content
        row :created_at
      end
    end

    if help_question.answered
      panel 'Ответ' do
        attributes_table_for help_question do
          row :reply
          row :replied_at
        end
      end
    end
  end

  index download_links: false do
    column '#' do |item|
      link_to item.display_name, admin_help_question_path(item)
    end
    column :name, sortable: false do |item|
      text_node item.name
      br
      small mail_to item.email
      br
      small item.created_at
    end
    column :content, sortable: false do |item|
      truncate item.content, length: 100
    end
    column :answered, sortable: false
    actions defaults: false do |help_question|
      item 'Ответить', reply_admin_help_question_path(help_question) unless help_question.answered
    end
  end
end