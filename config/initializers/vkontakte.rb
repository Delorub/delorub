VkontakteApi.configure do |config|
  config.adapter = :net_http
  config.http_verb = :post
  config.max_retries = 2
  config.logger        = Rails.logger
  config.log_requests  = true
  config.log_errors    = true
  config.log_responses = true
  config.api_version = '5.68'
end
