class AddDescriptionToPortfolioItem < ActiveRecord::Migration[5.1]
  def change
    add_column :portfolio_items, :description, :text
    add_column :portfolio_items, :deleted_at, :datetime, undex: true

    rename_column :portfolio_items, :profile_id, :portfolio_id
  end
end
