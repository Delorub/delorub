ActiveAdmin.register User, namespace: :admin do
  decorate_with UserDecorator

  include ActiveAdminShared::User
  include ActiveAdminShared::UserPermission
  include ActiveAdminShared::UserBilling

  permit_params :email, :first_name, :last_name, :password, :photo, :phone

  form do |f|
    inputs 'Основное' do
      input :email
      input :password if f.object.new_record?
      input :first_name
      input :last_name
      input :phone
      input :photo
    end
    actions
  end

  index do
    selectable_column
    column(:name) do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column :phone
    column :balance
    column :delocoin_balance
    column :created_at
    actions
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
