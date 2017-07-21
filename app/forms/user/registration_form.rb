class User::RegistrationForm < BaseForm
  property :name
  property :email
  property :sms_confirmation,
    prepopulator: ->(options) { self.sms_confirmation = SmsConfirmation.new },
    populator: -> (model:, **) { model || self.sms_confirmation = SmsConfirmation.new },
    form: SmsConfirmationForm,
    virtual: true
end
