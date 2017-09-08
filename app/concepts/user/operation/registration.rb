class User::Operation::Registration < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Registration)
    step :prepopulate!

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate!
    end
  end

  step Nested(Present)
  step Contract::Validate()
  step :set_phone!
  step :generate_password!
  step Contract::Persist()
  step :send_welcome_email!

  def set_phone! options, model:, **_
    model.phone = options['contract.default'].sms_confirmation.phone
    true
  end

  def generate_password! options, model:, **_
    options['generated_password'] = Devise.friendly_token 6
    model.password = options['generated_password']
    true
  end

  def send_welcome_email! generated_password:, model:, **_
    UserMailer.welcome(user: model, password: generated_password).deliver
    true
  end
end
