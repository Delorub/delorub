class Task::Operation::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Task, :new)
    step Contract::Build(builder: :default_contract!)
    step :prepopulate!

    def default_contract! options, model:, **_
      if options['current_user']
        Task::Contract::UserForm.new(model, current_user: options['current_user'])
      else
        Task::Contract::GuestForm.new(model, current_user: options['current_user'])
      end
    end

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate! params
    end
  end

  step Nested(Present)
  step Policy::Pundit(TaskPolicy, :create?)
  step Contract::Validate()
  step :register_new_user!
  step :skip_moderation!
  step Contract::Persist()

  def register_new_user! options, params:, model:, **_
    unless options['current_user'].nil?
      model.user = options['current_user']
      return true
    end
    result = User::Registration.call(params['new_user'].to_hash)
    return false if result.failure?
    model.user = result['model']
    options['sign_in_new_user'] = result['model']
  end

  def skip_moderation! model:, **_
    model.accept!
    true
  end
end
