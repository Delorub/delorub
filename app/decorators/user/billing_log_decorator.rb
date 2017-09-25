class User::BillingLogDecorator < Draper::Decorator
  decorates User::BillingLog
  decorates_association :billable
  delegate_all

  def billable_name
    billable.name
  end

  def billable_description
    billable.description
  end
end
