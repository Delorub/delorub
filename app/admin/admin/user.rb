ActiveAdmin.register User, namespace: :admin do
  permit_params :email, :first_name, :last_name, :phone, :password, :photo

  filter :email
  filter :first_name
  filter :last_name
  filter :phone

  scope :all, default: true
  scope :customer do |users|
    users
  end
  scope :master do |users|
    users.where{ profile_id != nil }
  end

  index do
    selectable_column
    column(:name) do |user|
      link_to "#{user.name}", admin_user_path(user)
    end
    column :email
  end
  
  member_action :permission, method: [:get, :put] do
    @permission_resource = resource.permission || resource.build_permission
    
    if request.put?
      @permission_resource.attributes = params[:user_permission].permit(@permission_resource.data.class.permissions)
      if @permission_resource.save
        redirect_to resource_path, notice: "Права доступа успешно обновлены"
      end
    end
  end

  member_action :transfer_money, method: [:get, :put] do
    @billing_resource = Billing::TransferManually.new(user: resource)

    if request.put?
      @billing_resource.attributes = params[:billing_transfer_manually].permit(:amount)
      if @billing_resource.save
        redirect_to resource_path, notice: "Сумма успешно зачислена на счет"
      end
    end
  end

  member_action :add_task_subscription, method: [:get, :put] do
    @billing_resource = Billing::TaskSubscription.new(user: resource)

    if request.put?
      @billing_resource.attributes = params[:billing_task_subscription].permit(:active_from, :active_to, :cost)
      if @billing_resource.save
        redirect_to resource_path, notice: "Подписка успешно активирована"
      end
    end
  end

  member_action :add_reply_subscription, method: [:get, :put] do
    @billing_resource = Billing::ReplySubscription.new(user: resource)

    if request.put?
      @billing_resource.attributes = params[:billing_reply_subscription].permit(:active_from, :active_to, :cost)
      if @billing_resource.save
        redirect_to resource_path, notice: "Подписка успешно активирована"
      end
    end
  end

  member_action :add_task_pack, method: [:get, :put] do
    @billing_resource = Billing::TaskPack.new(user: resource)

    if request.put?
      @billing_resource.attributes = params[:billing_task_pack].permit(:amount, :cost)
      if @billing_resource.save
        redirect_to resource_path, notice: "Пакет успешно активирован"
      end
    end
  end
  
  member_action :add_reply_pack, method: [:get, :put] do
    @billing_resource = Billing::ReplyPack.new(user: resource)

    if request.put?
      @billing_resource.attributes = params[:billing_reply_pack].permit(:amount, :cost)
      if @billing_resource.save
        redirect_to resource_path, notice: "Пакет успешно активирован"
      end
    end
  end

  show do
    render partial: 'show'
  end

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

  sidebar 'Биллинг', only: :show, if: proc{ authorized? :billing_log_sidebar, user } do
    render partial: 'billing_log_sidebar', locals: { user: user }
  end

  sidebar 'Пакеты и подписки', only: :show, if: proc{ authorized? :billing_sidebar, user }  do
    render partial: 'billing_sidebar', locals: { user: user }
  end

  sidebar 'Права доступа', only: :show, if: proc{ authorized? :permission, user } do
    render partial: 'permission_sidebar', locals: { user: user }
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