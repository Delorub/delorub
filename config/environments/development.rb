Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false

  config.app_domain = 'localhost:3000'

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.yandex.ru',
    port:                 25,
    #tls:                  true,
    #domain:               'yandex.ru',
    user_name:            'bstclub-noreply@yandex.ru',
    password:             '2478samsung123',
    authentication:       'login',
    enable_starttls_auto: true  }
end
