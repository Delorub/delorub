class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[5.1]
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    User.find_each do |user|
      first_name, last_name = user.first_name.split ' '
      user.update_attributes!(first_name: first_name, last_name: last_name)
    end
    remove_column :users, :name, :string
  end

  def down; end
end
