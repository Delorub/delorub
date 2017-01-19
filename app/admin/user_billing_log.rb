ActiveAdmin.register User::BillingLog do
  config.batch_actions = false

  filter :user
  filter :billable_type
  filter :created_at

  index do
    column :billable
    column :sum do |log|
      span class: (log.sum < 0 ? 'red' : 'green') do
        "#{log.sum} руб."
      end
    end
    column :user
    column :created_at
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
