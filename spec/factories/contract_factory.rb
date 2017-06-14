FactoryGirl.define do
  factory :contract do
    association :template, factory: :contract_template
  end
end
