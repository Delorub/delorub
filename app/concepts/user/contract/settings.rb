class User::Contract::Settings < Reform::Form
  property :email
  property :new_password, virtual: true
  property :phone, parse: false
  property :sms_confirmation,
    prepopulator: ->(options) {
      self.sms_confirmation = fake_accepted_sms_confirmation(phone)
    },
    populator: ->(model:, fragment:, **) {
      return if fragment['phone'] == phone
      self.sms_confirmation = SmsConfirmation.find_by(
        token: fragment['token'],
        phone: PhonyRails.normalize_number(fragment['phone'])
      ) || SmsConfirmation.new
    },
    form: SmsConfirmation::Contract::Form,
    virtual: true

  validates :email, presence: true, email: true
  validates :new_password, length: { within: 6..40 }, allow_blank: true

  def fake_accepted_sms_confirmation phone
    return SmsConfirmation.new if phone.blank?
    SmsConfirmation.new(token: 'fake', phone: self.phone, accepted: true)
  end
end
