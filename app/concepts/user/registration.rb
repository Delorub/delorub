class User::Registration < Trailblazer::Operation
  class Form < Reform::Form
    property :first_name
    property :email
    property :sms_confirmation,
      prepopulator: ->(options) { self.sms_confirmation = SmsConfirmation.new },
      populator: ->(model:, fragment:, **) {
        self.sms_confirmation = SmsConfirmation.find_by(
          token: fragment['token'],
          phone: PhonyRails.normalize_number(fragment['phone'])
        ) || SmsConfirmation.new
      },
      form: SmsConfirmation::Contract::UserRegistrationForm,
      virtual: true
    property :accept_terms, virtual: true, default: false

    validates :first_name, :email, :sms_confirmation, :accept_terms, presence: true
    validates :accept_terms, inclusion: { in: ['1'], message: 'Вы должны согласиться с правилами сервиса' }
    validates :email, email: true
    validates_uniqueness_of :email
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
  step Contract::Validate()
  step :set_phone!
  step :generate_password!
  step Contract::Persist()
  step :send_welcome_email!

  def set_phone! options, model:, **_
    model.phone = options['contract.default'].sms_confirmation.phone
    true
  end

  def generate_password! options, model:, **_
    options['generated_password'] = Devise.friendly_token 6
    model.password = options['generated_password']
    true
  end

  def send_welcome_email! generated_password:, model:, **_
    UserMailer.welcome(user: model, password: generated_password).deliver
    true
  end
end
