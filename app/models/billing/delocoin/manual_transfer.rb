class Billing::Delocoin::ManualTransfer < ApplicationRecord
  self.table_name = 'billing_delocoin_manual_transfer'

  include Billing::Base

  belongs_to :admin, class_name: 'User'

  validates :admin, presence: true

  def name
    'Ручное пополнение Delocoin'
  end
end
