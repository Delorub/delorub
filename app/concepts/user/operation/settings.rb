class User::Operation::Settings < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: ::User::Contract::Settings)
    step :prepopulate!

    def model! options, params:, **_
      options['model'] = options['current_user']
    end

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate!
    end
  end

  step Nested(Present)
  step Contract::Validate()
  step :set_password_if_changed!
  step Contract::Persist()

  def set_password_if_changed! options, model:, params:, **_
    return true if options['contract.default'].new_password.blank?
    model.password = options['contract.default'].new_password
    true
  end
end
