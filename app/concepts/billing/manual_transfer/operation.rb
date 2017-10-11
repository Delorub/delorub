module Billing::ManualTransfer::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::ManualTransfer, :new)
      step Contract::Build(constant: ::Billing::ManualTransfer::Contract)
    end

    step Nested(Present)
    step Policy::Pundit(Admin::UserPolicy, :transfer_money?)

    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        success :set_admin!
        success :set_user!
        step Contract::Validate()
        step Contract::Persist()
        success :put_options_sum!
        step User::BillingLog::Step::Create
      }
    }
    failure User::BillingLog::Step::Fail

    def put_options_sum! options, model:, **_
      options['sum'] = model.amount
    end

    def set_admin! options, params:, **_
      params['admin'] = options['current_user']
    end

    def set_user! options, params:, **_
      params['user'] = options[:user]
      options['current_user'] = options[:user]
    end
  end

  class Finish < Trailblazer::Operation
    step Model(::Billing::ManualTransfer, :find_by)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        success :set_current_user!
        step User::BillingLog::Step::Finish
      }
    }
    failure User::BillingLog::Step::Fail

    def set_current_user! options, params:, model:, **_
      options['current_user'] = model.user
    end
  end
end
