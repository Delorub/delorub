ActiveAdmin.register_page 'Dashboard', namespace: :admin do
  menu priority: 1, label: proc{ 'Главная' }

  content title: proc { I18n.t('active_admin.dashboard') } do
    if authorized? :search
      render partial: 'admin/shared/searchbox', locals: { query: '' }
    end
  end
end
