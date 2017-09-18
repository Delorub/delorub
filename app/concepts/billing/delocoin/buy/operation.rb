module Billing::Delocoin::Buy::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::Delocoin::Buy, :new)
      step Contract::Build(constant: ::Billing::Delocoin::Buy::Contract)
    end

    step Nested(Present)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
      step Contract::Validate()
      step Contract::Persist()
      step ->(options, model:, **_) {
        options['sum'] = -model.amount
      }
      step User::BillingLog::Step::Create
    }
  end

  class Finish < Trailblazer::Operation
    step Model(Task, :find_by)
  end
end
