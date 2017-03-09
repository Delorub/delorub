class CreateContractCategories < ActiveRecord::Migration
  def change
    create_table :contract_categories do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
