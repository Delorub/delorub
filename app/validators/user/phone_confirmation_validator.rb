class User::PhoneConfirmationValidator < ActiveModel::Validator
  def validate record
    normalized_phone = record.phone.phony_normalized
    confirmed_phone = User.confirmed_phone(normalized_phone).take

    return if confirmed_phone.nil? || confirmed_phone.id == record.id

    record.errors.add :phone, :phone_already_confirmed
  end
end
