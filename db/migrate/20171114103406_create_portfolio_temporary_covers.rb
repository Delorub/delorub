class CreatePortfolioTemporaryCovers < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolio_temporary_covers do |t|
      t.string :cover

      t.timestamps
    end
  end
end
