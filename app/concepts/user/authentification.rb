class User::Authentification < Trailblazer::Operation
  class Form < Reform::Form
    property :sign_in_as, virtual: true, default: 'user'
    property :email_or_phone, virtual: true
    property :password

    property :sms_confirmation,
      populator: ->(model:, fragment:, **) {
        self.sms_confirmation = SmsConfirmation.find_by(
          token: fragment['token'],
          phone: PhonyRails.normalize_number(email_or_phone)
        ) || SmsConfirmation.new
      },
      form: SmsConfirmation::Contract::CreateForm,
      virtual: true

    validates :email_or_phone, :sign_in_as, presence: true
    validates :sign_in_as, inclusion: { in: %w[user master] }
  end

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: Form)
  end

  step Model(User, :new)
  step Contract::Build(constant: Form)
  step Contract::Validate()
  step :model!
  step :authorize!

  def model! options, params:, **_
    options['user'] = \
      User.find_by(email: params[:email_or_phone]) ||
      User.by_phone(params[:email_or_phone]).first
  end

  def authorize! options, params:, **_
    return true if options['user'].valid_password? params[:password]
    if params['sms_confirmation'].present?
      result = SmsConfirmation::Operation::Check.call params['sms_confirmation']
      return true if result.success?
    end
    false
  end
end
