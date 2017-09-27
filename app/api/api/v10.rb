class Api::V10 < Grape::API
  mount Api::V10::SmsConfirmations
  mount Api::V10::Tasks
  mount Api::V10::Categories
  mount Api::V10::Places
  mount Api::V10::Users
  mount Api::V10::Billings
end
