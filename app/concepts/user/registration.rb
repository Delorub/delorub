class User::Registration < Trailblazer::Operation
  class Form < Reform::Form
    property :name
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

    validates :name, :email, :sms_confirmation, :accept_terms, presence: true
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
  step Contract::Validate()
end
