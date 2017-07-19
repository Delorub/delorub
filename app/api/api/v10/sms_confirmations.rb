class Api::V10::SmsConfirmations < ApplicationAPI
  namespace :sms_confirmations do
    desc 'Send code and get token'
    params do
      requires :phone, type: String, desc: 'Phone'
    end
    post do
      present :phone, params[:phone]
      present SmsConfirmation.create(phone: params[:phone])
    end

    desc 'Confirm code'
    params do
      requires :token, type: String, desc: 'Token'
      requires :code, type: String, desc: 'Confirmation code'
    end
    put do
      sms_confirmation = SmsConfirmation.find_by! token: params[:token]
      sms_confirmation.check_code! params[:code]
      present sms_confirmation
    end
  end
end
