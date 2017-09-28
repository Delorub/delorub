# == Schema Information
#
# Table name: billing_delocoin_buys
#
#  id              :integer          not null, primary key
#  pack_id         :integer
#  pay_type        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cost            :float
#  delocoin_amount :integer
#  step_id         :integer
#

FactoryGirl.define do
  factory :billing_delocoin_buy, class: Billing::Delocoin::Buy do
    transient do
      user { create user }
      state nil
    end

    pay_type 'balance'
    association :pack, factory: :delocoin_pack
    association :step, factory: :delocoin_step

    cost { pack.cost }
    delocoin_amount do
      Delocoin::ConvertService.new.balance_to_delocoins(step: step, pack: pack, balance: pack.cost)
    end

    after(:create) do |model, evaluator|
      create(:user_billing_log, billable: model, sum: -model.cost, user: evaluator.user, state: evaluator.state)
    end
  end
end
