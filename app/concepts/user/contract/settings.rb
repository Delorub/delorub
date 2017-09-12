class User::Contract::Settings < Reform::Form
  property :email
  property :new_password, virtual: true
  property :phone, parse: false
  property :sms_confirmation,
    prepopulator: ->(options) {
      self.sms_confirmation = fake_accepted_sms_confirmation(phone)
    },
    populator: ->(fragment:, **) {
      normalized_phone = PhonyRails.normalize_number(fragment['phone'])
      return if normalized_phone == phone

      self.sms_confirmation = SmsConfirmation.find_by(
        token: fragment['token'],
        phone: normalized_phone
      ) || SmsConfirmation.new(phone: normalized_phone)

      self.phone = normalized_phone
    },
    form: SmsConfirmation::Contract::Form,
    virtual: true

  validates :email, presence: true, email: true
  validates :phone, presence: true
  validates :sms_confirmation, presence: true
  validates :new_password, length: { within: 6..40 }, allow_blank: true
  validates_uniqueness_of :email
  validates_uniqueness_of :phone, allow_blank: true

  def fake_accepted_sms_confirmation phone
    return SmsConfirmation.new if phone.blank?
    SmsConfirmation.new(token: 'fake', phone: self.phone, accepted: true)
  end
end
