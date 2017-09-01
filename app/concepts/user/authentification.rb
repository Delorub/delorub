class User::Authentification < Trailblazer::Operation
  class Form < Reform::Form
    property :signed_in_as, virtual: true, default: 'user'
    property :email
    property :password

    validates :email, :password, :signed_in_as, presence: true
    validates :signed_in_as, inclusion: { in: %w[user master] }
  end

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: Form)
  end

  step Nested(Present)
  step Contract::Validate()
  step :model!
  step :check_password!

  def model! options, params:, **_
    options['user'] = User.find_or_initialize_by email: params[:email]
  end

  def check_password! options, params:, **_
    options['user'].valid_password? params[:password]
  end
end
