class User::Operation::InlineRegistration < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::InlineRegistration)
    step :prepopulate!

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate!
    end
  end

  step Nested(Present)
  step Contract::Validate()
  step :authorize_or_register!

  def authorize_or_register! options, params:, model:, **_
    if authentification_user.present?
      self['model'] = authentification_user
      return true
    end

    return false if registration.failure?
    self['model'] = registration['model']

    true
  end

  private

    def authentification_user
      @_authentification_user ||= ::User.by_phone(self['params']['sms_confirmation_attributes']['phone']).first
    end

    def registration
      @_registration ||= User::Operation::Registration.call(self['params'])
    end
end
