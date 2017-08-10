module SmsConfirmation::Operation
  class Create < Trailblazer::Operation
    step Model(SmsConfirmation, :new)
    step Contract::Build(constant: SmsConfirmation::Contract::CreateForm)
    step :generate_token!
    step :generate_code!
    step Contract::Validate()
    step :send_sms!
    step Contract::Persist()

    def generate_token! options, model:, **_
      model.token = SecureRandom.hex
    end

    def generate_code! options, model:, **_
      model.code = [1, 1, 1, 1].map! { |x| (0..9).to_a.sample }.join
    end

    def send_sms! options, model:, **_
      model.last_sent_at = Time.zone.now
      SmsSender.new(
        phone: options['contract.default'].phone,
        message: I18n.t('user_sms_confirmation', code: model.code)
      ).perform
    end
  end
end
