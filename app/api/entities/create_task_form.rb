class Entities::CreateTaskForm < Grape::Entity
  expose :id
  expose :title
  expose :main_category_id
  expose :category_id
  expose :price_exact
  expose :date_type
  expose :date_actual
end
