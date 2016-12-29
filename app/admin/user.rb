ActiveAdmin.register User do
  permit_params do
    permitted = [:email, :first_name, :last_name, :phone, :password]
    permitted
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :phone

  scope :all, default: true
  scope :customer do |users|
    users
  end
  scope :master do |users|
    users.where(is_master: true)
  end
  
  index do
    selectable_column
    column(:name) do |user|
      link_to "#{user.name}", admin_user_path(user)
    end
    column :email
  end
  
  action_item :roles, only: :show do
    link_to 'Управление доступом', user_path(user)
  end

  show do
    h3 'Основная информация'
    attributes_table_for user do
      row :email
      row :first_name
      row :last_name
      row :phone
    end

    h3 'Доступные действия'
    attributes_table_for user do
      row :available_answers
      row :paid_answers
      row :available_tasks
      row :paid_tasks
    end

    h3 'Анкета мастера'
    div do
      para 'Пользователь не заполнил анкету мастера.'
    end

    h3 'Задания'
    div do
      para 'Ничего на найдено'
    end
  end

  form do |f|
    inputs 'Основное' do
      input :email
      input :password if f.object.new_record?
      input :first_name
      input :last_name
      input :phone
      li "Создан #{f.object.created_at}" unless f.object.new_record?
    end
    actions
  end

  sidebar 'Права доступа', only: :show do
    para 'Этот пользователь не имеет прав доступа'
  end
  
  sidebar 'Платные функции', only: :show do
    para 'Ничего не найдено'
  end

  sidebar 'Активность', only: :show do
    attributes_table_for user do
      row :created_at
      row :last_sign_in_at
    end
  end
  
  sidebar 'Безопасность', only: :show do
    attributes_table_for user do
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end
end
