class Entities::Comment < Grape::Entity
  expose :id
  expose :user_id
  expose :text
  expose :created_at
  expose :updated_at
end
