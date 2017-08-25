class User::Omniauth < Trailblazer::Operation
  class Form < Reform::Form
    property :name
    property :email

    validates :name, :email, presence: true
    validates :email, email: true
  end

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: Form)
    step :prepopulate!

    def prepopulate! options, params:, **_
      options['contract.default'].prepopulate!
    end
  end

  step Nested(Present)
  step :generate_password!
  step Contract::Validate()
  step Contract::Persist()

  def generate_password! options, model:, **_
    model.password = 'test123'
  end
end
