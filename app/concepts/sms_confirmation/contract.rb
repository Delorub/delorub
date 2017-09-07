module SmsConfirmation::Contract
  class Base < ::BaseForm
    property :phone
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

        def user_unique? value
          User.by_phone(value).empty?
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

  class UserRegistrationForm < Form
    validation :default, inherit: true do
      required(:phone).filled(user_unique?: :phone)
    end
  end
end
