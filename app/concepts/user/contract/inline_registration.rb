class User::Contract::InlineRegistration < Reform::Form
  property :first_name
  property :email
  property :sms_confirmation,
    prepopulator: ->(options) { self.sms_confirmation = SmsConfirmation.new },
    populator: ->(model:, fragment:, **) {
      self.sms_confirmation = SmsConfirmation.find_by(
        token: fragment['token'],
        phone: PhonyRails.normalize_number(fragment['phone'])
      ) || SmsConfirmation.new
      self.phone = sms_confirmation.phone
    },
    form: SmsConfirmation::Contract::Form,
    virtual: true
  property :accept_terms, virtual: true, default: false
  property :phone, parse: false

  validates :first_name, :phone, :email, :sms_confirmation, :accept_terms, presence: true
  validates :accept_terms, inclusion: { in: ['1'], message: 'Вы должны согласиться с правилами сервиса' }
  validates :email, email: true
  validates_uniqueness_of :email, unless: :user_with_this_credentials_exists?
  validates_uniqueness_of :phone, allow_blank: true, unless: :user_with_this_credentials_exists?

  private

    def user_with_this_credentials_exists?
      User.by_phone(phone).where(email: email).exists?
    end
end
