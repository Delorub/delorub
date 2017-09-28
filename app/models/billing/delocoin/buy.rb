# == Schema Information
#
# Table name: billing_delocoin_buys
#
#  id              :integer          not null, primary key
#  pack_id         :integer
#  pay_type        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cost            :float
#  delocoin_amount :integer
#  step_id         :integer
#

require_dependency 'billing/delocoin'

class Billing::Delocoin::Buy < ApplicationRecord
  self.table_name = 'billing_delocoin_buys'

  extend Enumerize
  include Billing::Base

  enumerize :pay_type, in: Billing::PaymentTypeList.for(self)

  belongs_to :pack, class_name: '::Delocoin::Pack'
  belongs_to :step, class_name: '::Delocoin::Step'

  def name
    'Покупка Delocoin'
  end
end
