# == Schema Information
#
# Table name: billing_yandex_kassa_deposits
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  pay_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :string
#  params     :text
#

FactoryGirl.define do
  factory :billing_yandex_kassa_deposit, class: Billing::YandexKassa::Deposit do
    transient do
      user { create user }
      state 'new'
    end

    uuid SecureRandom.uuid
    pay_type { pay_type }
    amount { amount }

    after(:create) do |model, evaluator|
      create(:user_billing_log, billable: model, sum: model.amount, user: evaluator.user, state: evaluator.state)
    end
  end
end
