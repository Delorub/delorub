class CreateContractCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :contract_categories do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
