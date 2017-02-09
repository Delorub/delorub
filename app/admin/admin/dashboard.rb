ActiveAdmin.register_page "Dashboard", namespace: :admin do
  menu priority: 1, label: proc{ 'Главная' }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    render partial: 'admin/shared/searchbox', locals: { query: '' } if authorized? :search
  end
end
