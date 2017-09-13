class Entities::Places::City < Grape::Entity
  expose :id
  expose :name
  expose :full_name
  expose :slug
end
