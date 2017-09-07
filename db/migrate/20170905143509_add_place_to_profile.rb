class AddPlaceToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :place, index: true
  end
end
