# == Schema Information
#
# Table name: billing_yandex_kassa_deposits
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  pay_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::YandexKassa::Deposit < ApplicationRecord
  self.table_name = 'billing_yandex_kassa_deposits'

  include Billing::Base

  def name
    'Пополнение через Яндекс.Кассу'
  end
end
