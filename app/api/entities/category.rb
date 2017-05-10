class Entities::Category < Grape::Entity
  expose :id
  expose :title
  expose :parent_id
end
