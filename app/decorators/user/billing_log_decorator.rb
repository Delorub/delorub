class User::BillingLogDecorator < Draper::Decorator
  decorates User::BillingLog
  decorates_association :billable
  delegate_all

  delegate :name, :description, to: :billable
end
