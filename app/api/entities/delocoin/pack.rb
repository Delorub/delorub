class Entities::Delocoin::Pack < Grape::Entity
  expose :id
  expose :cost
  expose :discount_in_percents
  expose :one_delocoin_cost
  expose :delocoin_amount
  expose :delocoin_cost_on_last_step
  expose :delocoin_cost_next_year
end
