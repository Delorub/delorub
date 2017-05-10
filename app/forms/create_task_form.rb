class CreateTaskForm < Reform::Form
  property :title

  property :category_id
  property :price_exact
  property :main_category_id, virtual: true

  property :date_type, default: 'actual'
  property :date_actual
end
