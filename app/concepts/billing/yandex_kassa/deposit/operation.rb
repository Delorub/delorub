module Billing::YandexKassa::Deposit::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(::Billing::YandexKassa::Deposit, :new)
      step Contract::Build(constant: ::Billing::YandexKassa::Deposit::Contract)
    end

    step Nested(Present)
    # step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
      step Contract::Validate()
      step :generate_uuid!
      step Contract::Persist()

      step ->(options, model:, **_) {
        options['sum'] = model.amount
      }
      step User::BillingLog::Step::Create
    # }

    def generate_uuid! options, model:, **_
      count = 0
      model.uuid = loop do
        count += 1
        random_token = Digest::SHA1.hexdigest([Time.now.utc, rand].join)
        break random_token unless Billing::YandexKassa::Deposit.exists?(uuid: random_token)
        break if count >= 5
      end
      model.uuid.present?
    end
  end

  class Finish < Trailblazer::Operation
    step :model!
    step ->(options, params:, model:, **_) {
      aviso = Billing::YandexKassa::RequestService.new(params, model, 'paymentAviso')
      aviso.valid_signature?
    }
    step User::BillingLog::Step::Finish
    failure User::BillingLog::Step::Fail

    def model! options, params:, **_
      options['model'] = Billing::YandexKassa::Deposit.find_by uuid: params['orderNumber']
    end
  end

  class Check < Trailblazer::Operation
    step :model!
    success :save_params!
    step ->(options, params:, model:, **_) {
      check_order = Billing::YandexKassa::RequestService.new(params, model, 'checkOrder')
      check_order.valid_params?
    }

    def save_params! options, params:, model:, **_
      model.params = params
      model.save
    end

    def model! options, params:, **_
      options['model'] = Billing::YandexKassa::Deposit.find_by uuid: params['orderNumber']
    end
  end

  class Fail < Trailblazer::Operation
    step Model(Billing::YandexKassa::Deposit, :find_by)
    step Policy::Pundit(Billing::YandexKassa::DepositPolicy, :billing_log_is_new?)
    step User::BillingLog::Step::Fail
  end
end
