class PlaceSearch
  attr_reader :query, :page, :per_page, :place_type

  def initialize query:, page: 1, per_page: 20, type: nil
    @page = page
    @query = query
    @per_page = per_page
    @place_type = place_type_value type
  end

  def all
    searchkick_query
  end

  private

    def searchkick_query
      @searchkick_query ||= searchkick_search
    end

    def searchkick_search
      Searchkick.search query,
        index_name: Place,
        fields: ['name^10', 'place_type_name^10', 'full_name^2', 'search_string'],
        match: :word_start,
        page: page,
        per_page: per_page,
        where: {
          place_type: place_type
        }
    end

    def place_type_value type
      if type.present? && type == 'city'
        city_types
      else
        all_types
      end
    end

    def all_types
      Place.place_type.values
    end

    def city_types
      all_types - %w[street house]
    end
end
