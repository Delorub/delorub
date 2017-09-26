class User::BillingLog::Step
  class Create
    extend Uber::Callable

    def self.call options, **_
      options['billing_log'] = User::BillingLog::Operation::Create.call(
        {
          user: options['current_user'],
          billable: options['model'],
          sum: options['sum'].to_i
        },
        'current_user' => options['current_user']
      )

      options['billing_log'].success?
    end
  end

  class Check
    extend Uber::Callable

    def self.call options, **_
      options['current_user'].balance >= -options['sum'].to_i
    end
  end

  class Fail
    extend Uber::Callable

    def self.call options, model:, **_
      # TODO: write error to billing log
      p '@@@ FAIL @@@'
      p options

      if model.present? && model.billing_log.present?
        User::BillingLog::Operation::Fail.call(
          { id: model.billing_log.id },
          'current_user' => options['current_user']
        )
      end

      false
    end
  end

  class RescueFail
    extend Uber::Callable

    def self.call exception, options
      # TODO: remove it and write exception to the logger
      p '@@@ RESCUE FAIL @@@'
      p exception

      false
    end
  end

  class Finish
    extend Uber::Callable

    def self.call options, model:, **_
      result = User::BillingLog::Operation::Finish.call(
        { id: model.billing_log.id },
        'current_user' => options['current_user']
      )

      result.success?
    end
  end
end
