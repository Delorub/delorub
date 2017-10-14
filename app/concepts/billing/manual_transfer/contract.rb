class Billing::ManualTransfer::Contract < Reform::Form
  property :amount
  property :admin
  property :user_id

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 1, less_than: 1_000_000 }
  validates :admin, :user_id, presence: true
end
