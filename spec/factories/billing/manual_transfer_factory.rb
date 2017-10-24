# == Schema Information
#
# Table name: billing_manual_transfer
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_id   :integer
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :billing_manual_transfer, class: Billing::ManualTransfer do
    user
    association :admin, factory: :admin
    amount { rand(10.0..1000.0) }
  end
end
