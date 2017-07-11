class MovePlaceFromProfileToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :place_id, :integer
    remove_column :profiles, :place_id, :integer
    add_index :users, :place_id
  end
end
