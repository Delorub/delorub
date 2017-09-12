class User::Operation::Authentification < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Authentification)
  end

  step Nested(Present)
  step Contract::Validate()
  step :model!
  step :authorize!

  def model! options, params:, **_
    options['user'] = \
      User.find_by(email: params[:email_or_phone]) ||
      User.by_phone(params[:email_or_phone]).first
  end

  def authorize! options, params:, **_
    return true if options['user'].valid_password? params['password']
    if params['sms_confirmation'].present?
      result = SmsConfirmation::Operation::Check.call params['sms_confirmation']
      return true if result.success?
    end
    false
  end
end
