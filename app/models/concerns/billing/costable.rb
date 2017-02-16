module Billing::Costable
  extend ActiveSupport::Concern

  included do
    validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

    after_save :create_user_billing
  end

  private

    def create_user_billing
      user.billing_logs.create!(billable: self, sum: -cost)
    end
end
