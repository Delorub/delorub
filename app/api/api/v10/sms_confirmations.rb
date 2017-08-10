class Api::V10::SmsConfirmations < ApplicationAPI
  namespace :sms_confirmations do
    desc 'Send code and get token'
    params do
      requires :phone, type: String, desc: 'Phone'
    end
    post do
      result = SmsConfirmation::Operation::Create.call(params)
      return error! result['contract.default'].errors if result.failure?
      present result['model'], with: Entities::SmsConfirmation
    end

    desc 'Confirm code'
    params do
      requires :token, type: String, desc: 'Token'
      requires :code, type: String, desc: 'Confirmation code'
    end
    put do
      result = SmsConfirmation::Operation::Check.call(params)
      return error! result['contract.default'].errors if result.failure?
      present result['model'], with: Entities::SmsConfirmation
    end
  end
end
