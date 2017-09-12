class Api::V10::SmsConfirmations < ApplicationAPI
  namespace :sms_confirmations do
    desc 'Send confirmation code by sms and get token'
    params do
      requires :phone, type: String, desc: 'Phone to be confirmed by sms'
    end
    post do
      result = SmsConfirmation::Operation::Create.call(params)
      return error!({ errors: result['contract.default'].errors.messages }, 200) if result.failure?
      present result['model'], with: Entities::SmsConfirmation
    end

    desc 'Confirm code'
    params do
      requires :token, type: String, desc: 'Token from /post'
      requires :code, type: String, desc: 'Confirmation code from sms'
    end
    put do
      result = SmsConfirmation::Operation::Check.call(params)
      return error!({ errors: { phone: ['Неверный код подтверждения'] } }, 200) if result.failure?
      present result['model'], with: Entities::SmsConfirmation
    end
  end
end
