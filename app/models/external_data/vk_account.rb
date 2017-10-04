# == Schema Information
#
# Table name: external_data_vk_accounts
#
#  id                          :integer          not null, primary key
#  login                       :string
#  password                    :string
#  state                       :string
#  access_token                :string
#  access_token_generated_at   :datetime
#  access_token_attempts_count :integer          default(0)
#  info                        :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class ExternalData::VkAccount < ApplicationRecord
  self.table_name = 'external_data_vk_accounts'

  include AASM

  after_create :generate_access_token_async

  validates :login, :password, presence: true

  aasm requires_new_transaction: false, column: :state, use_transactions: false do
    state :new, initial: true
    state :generating_access_token
    state :active
    state :error
    state :inactive

    event :generate_access_token do
      after :run_generate_access_token
      transitions from: [:new, :error], to: :generating_access_token
    end

    event :set_token_generated do
      after :update_access_token_generated_at
      transitions from: :generating_access_token, to: :active
    end

    event :set_error do
      transitions to: :error
    end

    event :set_inactive do
      transitions to: :inactive
    end

    error_on_all_events :log_error
  end

  private

    def generate_access_token_async
      ExternalData::VkAccount::GenerateTokenWorker.perform_async id
    end

    def run_generate_access_token
      save
      self.access_token_attempts_count += 1
      self.access_token = \
        ExternalData::VkApiAuthorizer.new(login: login, password: password).perform
      set_token_generated!
      save
    end

    def update_access_token_generated_at
      self.access_token_generated_at = Time.zone.now
    end

    def log_error e
      self.info = e.inspect
      set_error!
      save
      raise e
    end
end
