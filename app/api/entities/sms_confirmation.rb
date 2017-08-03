class Entities::SmsConfirmation < Grape::Entity
  expose :token
  expose :phone
  expose :accepted
  expose :created_at
end
