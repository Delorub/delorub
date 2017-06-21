class RemoveTitleFromPortfolioItem < ActiveRecord::Migration
  def change
    remove_column :portfolio_items, :title
  end
end
