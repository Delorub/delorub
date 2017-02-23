FactoryGirl.define do
  factory :billing_transfer_manually, class: Billing::TransferManually do
    user
    association :admin, factory: :admin
    amount { rand(10.0..1000.0) }
  end
end
