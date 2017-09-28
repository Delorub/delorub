# == Schema Information
#
# Table name: user_billing_logs
#
#  id            :integer          not null, primary key
#  sum           :float
#  user_id       :integer
#  billable_type :string
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string
#

FactoryGirl.define do
  factory :user_billing_log, class: User::BillingLog do
    user
    state 'new'
    sum { rand(10.0..1000.0) }
    association :billable
  end
end
