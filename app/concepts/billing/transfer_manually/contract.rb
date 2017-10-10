class Billing::TransferManually::Contract < Reform::Form
  property :amount

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 1, less_than: 1_000_000 }
  validates :admin_id, :user_id, presence: true
end
