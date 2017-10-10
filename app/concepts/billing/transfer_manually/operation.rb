module Billing::TransferManually::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::TransferManually, :new)
      step Contract::Build(constant: ::Billing::TransferManually::Contract)
    end

    step Nested(Present)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step Contract::Validate()
        step Contract::Persist()
        success :put_options_sum!
        success :set_current_user!
        step User::BillingLog::Step::Create
      }
    }
    failure User::BillingLog::Step::Fail

    def put_options_sum! options, model:, **_
      options['sum'] = model.amount
    end

    def set_current_user! options, params:, **_
      options['current_user'] = options['model'].user
    end
  end
end
