class Api::V10 < Grape::API
  mount Api::V10::SmsConfirmations
  mount Api::V10::Tasks
end
