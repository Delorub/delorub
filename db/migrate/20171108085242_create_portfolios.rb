class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.references :profile
      t.column :name, :string
      t.column :description, :text
      t.column :cover, :string
      t.column :deleted_at, :datetime, index: true

      t.timestamps
    end
  end
end
