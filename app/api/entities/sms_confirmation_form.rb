class Entities::SmsConfirmationForm < Grape::Entity
  expose :id
  expose :token
  expose :phone
  expose :accepted
  expose :created_at
end
