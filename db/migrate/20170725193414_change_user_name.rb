class ChangeUserName < ActiveRecord::Migration[5.1]
  class User < ActiveRecord::Base; end

  def change
    add_column :users, :name, :string
    User.find_each do |user|
      user.update_attributes!(name: "#{user.first_name} #{user.last_name}")
    end
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :skype
    remove_column :users, :website
  end
end
