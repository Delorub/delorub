class Entities::SmsConfirmation < Grape::Entity
  expose :token
  expose :created_at
  expose :code
end
