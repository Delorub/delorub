class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :file
      t.integer :profile_id, index: true

      t.timestamps null: false
    end
  end
end
