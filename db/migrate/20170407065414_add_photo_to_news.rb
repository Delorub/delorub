class AddPhotoToNews < ActiveRecord::Migration
  def change
    add_column :news, :photo, :string
  end
end
