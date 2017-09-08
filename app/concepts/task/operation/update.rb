class Task::Operation::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Task, :find_by)
    step Contract::Build(constant: Task::Contract::UserForm)
    step :prepopulate!

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate! params
    end
  end

  step Nested(Present)
  step Policy::Pundit(TaskPolicy, :update?)
  step Contract::Validate()
  step Contract::Persist()
end
