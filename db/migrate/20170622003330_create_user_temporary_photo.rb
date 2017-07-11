class CreateUserTemporaryPhoto < ActiveRecord::Migration[4.2]
  def change
    create_table :user_temporary_photos do |t|
      t.string :photo
    end
  end
end
