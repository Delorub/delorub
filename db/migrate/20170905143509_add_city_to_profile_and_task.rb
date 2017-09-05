class AddCityToProfileAndTask < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :city, index: true
    add_reference :tasks, :city, index: true
  end
end
