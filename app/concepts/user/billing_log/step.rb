class User::BillingLog::Step
  class Create
    extend Uber::Callable

    def self.call options, **_
      result = User::BillingLog::Operation::Create.call({
        user: options['current_user'],
        billable: options['model'],
        sum: options['sum'].to_i
      })

      result.success?
    end
  end

  class Finish
    extend Uber::Callable

    def self.call options, model:, **_
      result = User::BillingLog::Operation::Finish.call(id: model.billing_log.id)

      result.success?
    end
  end

  class Fail
    extend Uber::Callable
    def self.call options, model:, **_
      result = User::BillingLog::Operation::Fail.call(id: model.billing_log.id)
      result.success?
    end
  end
end
