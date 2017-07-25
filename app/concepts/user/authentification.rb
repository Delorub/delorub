class User::Authentification < Trailblazer::Operation
  class Form < Reform::Form
    property :sign_in_as, virtual: true
    property :email
    property :password

    validates :email, :password, presence: true
  end

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: Form)
  end

  step Nested(Present)
  step Contract::Validate()
  step :model!
  step :check_password!

  def model!(options, params:, **)
    options['user'] = User.find_by(email: params[:email])
  end

  def check_password!(options, params:, **)
    options['user'].valid_password? params[:password]
  end
end
