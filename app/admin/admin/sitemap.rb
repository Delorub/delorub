ActiveAdmin.register_page 'Sitemap', namespace: :admin do
  menu false

  controller do
    def index
      SiteMapWorker.perform_async
      redirect_to admin_dashboard_path, notice: 'Генерация Sitemap поставлена в очередь'
    end
  end
end
