class Task::Operation < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Task, :new)
    step Contract::Build(builder: :default_contract!)
    step :prepopulate!

    def default_contract! options, model:, **_
      if self[:current_user]
        Task::Contract::UserForm.new(model, current_user: self[:current_user])
      else
        Task::Contract::GuestForm.new(model, current_user: self[:current_user])
      end
    end

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate!
    end
  end

  step Nested(Present)
  step Contract::Validate()
  # step Contract::Persist()
end
