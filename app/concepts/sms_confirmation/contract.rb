module SmsConfirmation::Contract
  class Base < ::BaseForm
    property :phone
    property :token, writeable: false
    property :accepted, writeable: false
    property :created_at, writeable: false

    validation :default do
      configure do
        config.messages = :i18n

        def phone? value
          Phony.plausible? value
        end

        def accepted? value
          value
        end
      end

      required(:phone).filled(:str?, :phone?)
      required(:accepted).filled(:bool?)
    end
  end

  class CreateForm < Base
  end

  class Form < Base
    validation :default, inherit: true do
      rule(phone: [:phone, :accepted]) do |phone, accepted|
        phone.filled? & accepted.accepted?
      end
    end
  end
end
