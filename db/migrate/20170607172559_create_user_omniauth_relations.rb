class CreateUserOmniauthRelations < ActiveRecord::Migration[4.2]
  def change
    create_table :user_omniauth_relations do |t|
      t.integer :user_id
      t.string :provider
      t.string :external_id
      t.text :data
      t.timestamps null: false
    end

    add_index :user_omniauth_relations, :user_id
    add_index :user_omniauth_relations, [:provider, :external_id], unique: true
  end
end
