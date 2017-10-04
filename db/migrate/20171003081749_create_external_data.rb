class CreateExternalData < ActiveRecord::Migration[5.1]
  def change
    create_table :external_data do |t|
      t.text :data
      t.string :uid, unique: true
      t.string :source
      t.string :state

      t.timestamps null: false
    end
  end
end
