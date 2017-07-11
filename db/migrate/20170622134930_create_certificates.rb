class CreateCertificates < ActiveRecord::Migration[4.2]
  def change
    create_table :certificates do |t|
      t.string :file
      t.integer :profile_id, index: true

      t.timestamps null: false
    end
  end
end
