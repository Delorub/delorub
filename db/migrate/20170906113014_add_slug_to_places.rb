class AddSlugToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :slug, :string
    add_index :places, :slug

    say_with_time 'generating places slugs' do
      Place.only_cities.find_each(&:save)
    end
  end
end
