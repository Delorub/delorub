class Billing::Delocoin::Buy < ApplicationRecord
  self.table_name = 'billing_delocoin_buy'

  include Billing::Base

  def name
    'Покупка Delocoin'
  end
end
