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
  factory :deposit, class: Billing::YandexKassa::Deposit do
    uuid SecureRandom.uuid
    pay_type 'WQ'
    amount { rand(10..1000) }
    after(:create) do |deposit|
      create(:user_billing_log, billable: deposit, sum: deposit.amount)
    end
  end
end
