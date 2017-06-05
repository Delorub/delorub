module Searchable::Place
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:name, :full_name, :search_string], language: :russian

    scope :by_search_in, ->(q, type) {
      by_search_ids PlaceSearch.new(query: q, page: 1, per_page: 100, place_type: type).all.map(&:id)
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end
  end

  def search_data
    {
      full_name: full_name,
      name: name,
      place_type_name: place_type_name.search_string,
      search_string: search_string,
      place_type: place_type
    }
  end
end
