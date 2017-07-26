class SmsConfirmationForm < BaseForm
  property :phone
  property :token
  property :accepted
  property :created_at

  validation :default do
    configure do
      config.messages = :i18n

      def phone? value
        Phony.plausible? value
      end
    end

    required(:phone).filled(:str?, :phone?)
  end
end
