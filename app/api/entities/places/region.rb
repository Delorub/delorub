class Entities::Places::Region < Grape::Entity
  expose :id, documentation: { type: 'integer' }
  expose :name, documentation: { type: 'string' }
  expose :full_name, documentation: { type: 'string' }
  expose :cities, using: Entities::Places::City
end
