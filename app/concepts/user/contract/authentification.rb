class User::Contract::Authentification < Reform::Form
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
