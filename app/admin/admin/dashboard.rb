ActiveAdmin.register_page 'Dashboard', namespace: :admin do
  menu priority: 1, label: proc{ 'Главная' }

  content title: proc { I18n.t('active_admin.dashboard') } do
    if authorized? :search
      div style: 'margin-bottom:20px; text-align:right' do
        link_to 'Сгенерировать Sitemap', admin_sitemap_path, class: 'button'
      end
      render partial: 'admin/shared/searchbox', locals: { query: '' }
    end
  end
end
