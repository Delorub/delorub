class AddMainToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :main, :boolean, default: false
  end
end
