module Billing::Base
  extend ActiveSupport::Concern

  included do
    #belongs_to :user, through: :user_billing
    has_one :billing_log, class_name: '::User::BillingLog', as: :billable

    #validates :user, presence: true
  end
end
