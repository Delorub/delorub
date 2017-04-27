class CreateTaskForm < Reform::Form
  property :category_id
  property :price_exact
  property :main_category_id, virtual: true

  property :date_type, default: 'actual'
  property :date_actual

  def to_redux
    {
      main_category_id: main_category_id,
      category_id: category_id,
      price_exact: price_exact,
      date_type: date_type,
      date_actual: date_actual
    }
  end
end
