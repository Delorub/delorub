class CreateContractTemplates < ActiveRecord::Migration
  def change
    create_table :contract_templates do |t|
      t.string :title
      t.integer :category_id

      t.text :markup

      t.timestamps null: false
    end
  end
end
