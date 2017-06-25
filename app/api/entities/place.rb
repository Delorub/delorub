class Entities::Place < Grape::Entity
  expose :id, documentation: { type: 'integer' }
  expose :name, documentation: { type: 'string' }
  expose :region_name do |e|
    return nil if e.region_place.blank?
     e.region_place.display_name
  end
end
