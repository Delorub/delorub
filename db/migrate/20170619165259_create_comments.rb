class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, index: true
      t.integer :parent_id, index: true, default: nil
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
