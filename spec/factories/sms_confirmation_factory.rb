FactoryGirl.define do
  factory :sms_confirmation do
    sequence(:phone) { |n| Phony.format("7999#{1_234_567 + n}") }
  end
end
