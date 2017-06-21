class CreateUserTemporaryPhoto < ActiveRecord::Migration
  def change
    create_table :user_temporary_photos do |t|
      t.string :photo
    end
  end
end
