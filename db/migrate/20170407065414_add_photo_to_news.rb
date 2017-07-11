class AddPhotoToNews < ActiveRecord::Migration[4.2]
  def change
    add_column :news, :photo, :string
  end
end
