module Billing::Base
  extend ActiveSupport::Concern

  included do
    has_one :billing_log, class_name: '::User::BillingLog', as: :billable
  end
end
