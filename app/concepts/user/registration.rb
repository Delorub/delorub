class User::Registration < Trailblazer::Operation
  class Form < Reform::Form
    property :first_name
    property :email
    property :sms_confirmation,
      prepopulator: ->(options) { self.sms_confirmation = SmsConfirmation.new },
      populator: ->(model:, fragment:, **) {
        self.sms_confirmation = SmsConfirmation.find_by(
          token: fragment['token'],
          phone: fragment['phone']
        ) || SmsConfirmation.new
      },
      form: SmsConfirmation::Contract::Form,
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
  step :generate_and_send_password!
  step Contract::Validate()
  step Contract::Persist()

  def generate_and_send_password! options, model:, **_
    model.password = 'test123'
  end
end
