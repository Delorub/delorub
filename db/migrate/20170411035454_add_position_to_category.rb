class AddPositionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer
    Category.order(:updated_at).each.with_index(1) do |category, index|
      category.update_attributes position: index
    end
  end
end
