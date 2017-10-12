redis_config = Rails.application.config_for(:redis)

sidekiq_redis_config = {
  url: redis_config['url'] + '/' + (redis_config['db'] + 1).to_s
}

Sidekiq.configure_server do |config|
  config.redis = sidekiq_redis_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis_config
end
