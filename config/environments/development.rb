Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false

  config.public_file_server.enabled = true
  config.assets.compile = true

  config.app_domain = 'localhost:3000'

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.assets.compile = true

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: Figaro.env.base_url }
  config.action_mailer.asset_host = Figaro.env.base_url
end
