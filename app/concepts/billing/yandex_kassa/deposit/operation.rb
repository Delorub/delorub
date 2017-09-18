module Billing::YandexKassa::Deposit::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::YandexKassa::Deposit, :new)
      step Contract::Build(constant: ::Billing::YandexKassa::Deposit::Contract)
    end

    step Nested(Present)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
      step Contract::Validate()
      step Contract::Persist()
      step ->(options, model:, **_) {
        options['sum'] = model.amount
      }
      step User::BillingLog::Step::Create
    }
  end

  class Finish < Trailblazer::Operation
    step Model(Billing::YandexKassa::Deposit, :find_by)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
      step User::BillingLog::Step::Finish
    }
  end
end
