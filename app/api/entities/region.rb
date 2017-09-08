class Entities::Region < Grape::Entity
  expose :id, documentation: { type: 'integer' }
  expose :name, documentation: { type: 'string' }
  expose :cities, using: Entities::City
end
