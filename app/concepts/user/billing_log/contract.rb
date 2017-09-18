module User::BillingLog::Contract
  class Create < Reform::Form
    property :user
    property :billable
    property :sum

    validates :user, :billable, presence: true

    validates :sum, presence: true
    validates :sum, numericality: { only_integer: true, greater_than: -1_000_000, less_than: 1_000_000 }
  end
end
