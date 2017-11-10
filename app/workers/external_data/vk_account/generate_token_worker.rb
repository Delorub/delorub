class ExternalData::VkAccount::GenerateTokenWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5, queue: :external_data_critical, backtrace: true
  sidekiq_retry_in do |count|
    (10 * count).minutes
  end
  sidekiq_retries_exhausted do |msg, e|
    external_data_vk_account_id = msg['args'].first
    model = ExternalData::VkAccount.find_by id: external_data_vk_account_id
    model.set_inactive! if model.present?
  end

  def perform external_data_vk_account_id
    @model = ExternalData::VkAccount.find external_data_vk_account_id
    @model.generate_access_token
  end
end
