class CreatePortfolioItems < ActiveRecord::Migration
  def change
    create_table :portfolio_items do |t|
      t.string :title
      t.integer :profile_id, index: true
      t.string :file

      t.timestamps null: false
    end
  end
end
