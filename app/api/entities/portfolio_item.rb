class Entities::PortfolioItem < Grape::Entity
  expose :id
  expose :profile_id
  expose :file
end
