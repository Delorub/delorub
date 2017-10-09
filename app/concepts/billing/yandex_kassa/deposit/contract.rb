require 'reform/form/validation/unique_validator'

class Billing::YandexKassa::Deposit::Contract < Reform::Form
  property :amount
  property :pay_type, default: 'visa'
  property :accept_terms, virtual: true, default: false

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 1, less_than: 1_000_000 }

  validates :accept_terms, presence: true
  validates :accept_terms, inclusion: { in: ['1'], message: 'Вы должны согласиться с правилами сервиса' }

  validates :pay_type, presence: true
end
