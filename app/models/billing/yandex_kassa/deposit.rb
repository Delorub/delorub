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

  extend Enumerize
  include Billing::Base

  def name
    'Пополнение через Яндекс.Кассу'
  end
end
