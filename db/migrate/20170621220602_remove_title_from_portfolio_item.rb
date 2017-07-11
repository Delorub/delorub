class RemoveTitleFromPortfolioItem < ActiveRecord::Migration[4.2]
  def change
    remove_column :portfolio_items, :title
  end
end
