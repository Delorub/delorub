class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.column :code,   :string,  index: true, unique: true
      t.column :name,   :string
      t.column :active, :boolean, default: false
      t.timestamps
    end
  end
end
