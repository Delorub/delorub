class Entities::Place < Grape::Entity
  expose :id, documentation: { type: 'integer' }
  expose :display_name, documentation: { type: 'string' }
end
