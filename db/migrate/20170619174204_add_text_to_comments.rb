class AddTextToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :text, :text
  end
end
