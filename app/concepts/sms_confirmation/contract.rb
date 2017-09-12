module SmsConfirmation::Contract
  class Base < ::BaseForm
    property :phone,
      populator: ->(fragment:, **) {
        self.phone = PhonyRails.normalize_number(fragment)
      }
    property :token, writeable: false
    property :accepted, writeable: false
    property :created_at, writeable: false

    validation :default, with: { form: true } do
      configure do
        config.messages = :i18n

        option :form

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

  class Form < Base
    validation :default, inherit: true do
      rule(phone: [:phone, :accepted]) do |phone, accepted|
        phone.filled? & accepted.accepted?
      end
    end
  end

  class CreateForm < Base
  end
end
