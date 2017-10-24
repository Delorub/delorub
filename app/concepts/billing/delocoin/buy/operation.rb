module Billing::Delocoin::Buy::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::Delocoin::Buy, :new)
      step Contract::Build(builder: :default_contract!)
      step :prepopulate!

      def default_contract! options, model:, **_
        if options['current_user']
          Billing::Delocoin::Buy::Contract::UserForm.new(model, current_user: options['current_user'])
        else
          Billing::Delocoin::Buy::Contract::GuestForm.new(model, current_user: options['current_user'])
        end
      end

      def prepopulate! options, params:, **_
        options['contract.default'].prepopulate! params
      end
    end

    step Nested(Present)
    step Wrap(Billing::Transaction) {
      step Contract::Validate()
      step :set_current_step!
      step :calculate_amounts!
      success :set_pay_type!
      step User::BillingLog::Step::CheckBalance
      step :register_new_user!
      step Contract::Persist()
      step User::BillingLog::Step::Create
      step Billing::CreateNestedPayment
    }

    def set_current_step! options, model:, **_
      model.step = Delocoin::Step::CurrentService.new.perform
    end

    def set_pay_type! options, params:, **_
      options['pay_type'] = params['pay_type']
    end

    def calculate_amounts! options, model:, **_
      pack = options['contract.default'].pack
      model.cost = pack.cost
      model.delocoin_amount = Delocoin::ConvertService.new.balance_to_delocoins(step: model.step, pack: pack, balance: model.cost)
      options['sum'] = -model.cost
    end

    def register_new_user! options, params:, model:, **_
      return true unless options['current_user'].nil?

      result = User::Operation::InlineRegistration.call(params['new_user'].to_hash)
      return false if result.failure?

      options['sign_in_new_user'] = result['model']
      options['current_user'] = result['model']
    end
  end

  class Finish < Trailblazer::Operation
    step Model(::Billing::Delocoin::Buy, :find_by)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step User::BillingLog::Step::Finish
        step :update_user_delocoin_balance!
        success :send_buy_delocoin_email!
      }
    }
    failure User::BillingLog::Step::Fail

    def update_user_delocoin_balance! model:, **_
      # TODO: make sql
      model.user.delocoin_balance += model.delocoin_amount
      model.user.save
    end

    def send_buy_delocoin_email! options, model:, **_
      UserMailer.buy_delocoin(model: model).deliver_later
    end
  end
end
