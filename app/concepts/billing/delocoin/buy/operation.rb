module Billing::Delocoin::Buy::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::Delocoin::Buy, :new)
      step Contract::Build(constant: ::Billing::Delocoin::Buy::Contract)
      step :prepopulate!

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate! params
      end
    end

    step Nested(Present)
    step Wrap(Billing::Transaction) {
      step Contract::Validate()
      step :set_current_step!
      step :calculate_amounts!
      step Contract::Persist()
      step User::BillingLog::Step::Create
    }

    def set_current_step! options, model:, **_
      model.step = Delocoin::Step::CurrentService.new.perform
    end

    def calculate_amounts! options, model:, **_
      pack = options['contract.default'].pack
      model.cost = pack.cost
      model.delocoin_amount = Delocoin::ConvertService.new.balance_to_delocoins(step: model.step, pack: pack, balance: model.cost)
      options['sum'] = -model.cost
    end
  end

  class Confirm < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::Delocoin::Buy, :find_by)
    end
    step Nested(Present)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step :finish!
        failure User::BillingLog::Step::Fail
      }
    }

    def finish! options, model:, **_
      result = ::Billing::Delocoin::Buy::Operation::Finish.call(
        { id: model.id },
        'current_user' => options['current_user']
      )

      result.success?
    end
  end

  class Finish < Trailblazer::Operation
    step Model(::Billing::Delocoin::Buy, :find_by)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step User::BillingLog::Step::Finish
        step :update_user_delocoin_balance!
      }
    }
    failure User::BillingLog::Step::Fail

    def update_user_delocoin_balance! model:, **_
      user = model.billing_log.user

      # TODO: make sql
      user.delocoin_balance += model.delocoin_amount
      user.save
    end
  end
end
