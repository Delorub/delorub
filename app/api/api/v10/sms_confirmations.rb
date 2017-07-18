class Api::V10::SmsConfirmations < ApplicationAPI
  namespace :sms_confirmations do
    desc 'Sms confirmations'
    params do
      optional :phone, type: String, desc: 'Phone'
    end
    get :confirm do
      present :phone, params[:phone]
    end
  end
end
