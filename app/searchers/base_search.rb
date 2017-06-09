class BaseSearch
  attr_reader :query, :page, :per_page

  def initialize query:, page: 1, per_page: 20
    @page = page
    @query = query
    @per_page = per_page
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
        per_page: per_page
    end
end
