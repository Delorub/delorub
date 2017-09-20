# == Schema Information
#
# Table name: billing_yandex_kassa_deposits
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  pay_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :string
#  params     :text
#

class Billing::YandexKassa::Deposit < ApplicationRecord
  self.table_name = 'billing_yandex_kassa_deposits'
  serialize :params, JSON

  has_one :billing_log, class_name: 'User::BillingLog', as: :billable

  extend Enumerize
  include Billing::Base
  enumerize :pay_type, in: %w[WQ PC AC WM]
  after_initialize :defaults, if: :new_record?

  def name
    'Пополнение через Яндекс.Кассу'
  end

  private

    def defaults
      self.uuid ||= SecureRandom.uuid
    end
end
