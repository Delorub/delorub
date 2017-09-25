module Billing::YandexKassa::Deposit::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::YandexKassa::Deposit, :new)
      step Contract::Build(constant: ::Billing::YandexKassa::Deposit::Contract)
    end

    step Nested(Present)
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step Contract::Validate()
        success :generate_uuid!
        step Contract::Persist()
        step :put_options_sum!
        step User::BillingLog::Step::Create
      }
    }
    failure User::BillingLog::Step::Fail

    def generate_uuid! options, model:, **_
      count = 0
      model.uuid = loop do
        count += 1
        random_token = Digest::SHA1.hexdigest([Time.now.utc, rand].join)
        break random_token unless Billing::YandexKassa::Deposit.exists?(uuid: random_token)
        raise 'Uuid is not generated' if count >= 5
      end
    end

    def put_options_sum! options, model:, **_
      options['sum'] = model.amount
    end
  end

  class Finish < Trailblazer::Operation
    step :model!
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        step :valid_signature?
        step User::BillingLog::Step::Finish
      }
    }
    failure User::BillingLog::Step::Fail

    def model! options, params:, **_
      options['model'] = Billing::YandexKassa::Deposit.find_by uuid: params['orderNumber']
    end

    def valid_signature? options, params:, model:, **_
      aviso = Billing::YandexKassa::RequestService.new(params, model, 'paymentAviso')
      aviso.valid_signature?
    end
  end

  class Check < Trailblazer::Operation
    step :model!
    step Wrap(Billing::Transaction) {
      step Rescue(handler: User::BillingLog::Step::RescueFail) {
        success :save_params!
        step :valid_params?
      }
    }
    failure User::BillingLog::Step::Fail

    def save_params! options, params:, model:, **_
      model.params = params
      model.save
    end

    def valid_params? options, params:, model:, **_
      check_order = Billing::YandexKassa::RequestService.new(params, model, 'checkOrder')
      check_order.valid_params?
    end

    def model! options, params:, **_
      options['model'] = Billing::YandexKassa::Deposit.find_by uuid: params['orderNumber']
    end
  end

  class Fail < Trailblazer::Operation
    step Model(Billing::YandexKassa::Deposit, :find_by)
    step User::BillingLog::Step::Fail
  end
end
