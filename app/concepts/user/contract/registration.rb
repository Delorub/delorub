class User::Contract::Registration < Reform::Form
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
