ActiveAdmin.setup do |config|
  config.site_title = 'Делоруб'
  config.site_title_image = '/images/design/logo.png'
  config.register_stylesheet 'https://fonts.googleapis.com/css?family=Exo+2:100,200,300,400,500,600,700&amp;subset=cyrillic'

  config.authentication_method = :authenticate_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.authorization_adapter = ActiveAdmin::PermissionAuthorizationAdapter
  config.on_unauthorized_access = :active_admin_access_denied

  config.batch_actions = true
  config.comments = false
  config.localize_format = :long
  config.filters = true

  config.namespace :admin do |admin|
    admin.site_title = 'Панель администратора'
  end

  config.namespace :editor do |editor|
    editor.site_title = 'Панель редактора'
  end
end
