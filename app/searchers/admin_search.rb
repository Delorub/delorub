class AdminSearch
  attr_reader :query

  def initialize query:, page: 1
    @page            = page
    @query           = query
  end

  def search_classes
    [User, Category, News, Page]
  end

  def all
    searchkick_query
  end

  private

    def searchkick_query
      @searchkick_query ||= searchkick_search
    end

    def searchkick_search
      Searchkick.search query, index_name: search_classes
    end
end
