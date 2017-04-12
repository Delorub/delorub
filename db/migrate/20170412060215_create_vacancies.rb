class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :title
      t.text :small_description
      t.text :description
      t.integer :position
      t.boolean :archive, default: false
    end
  end
end
