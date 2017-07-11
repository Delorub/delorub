class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.boolean :draft
      t.timestamps null: false
    end
  end
end
