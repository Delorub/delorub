class SearchCategoriesService
  attr_reader :query, :collection

  def initialize query:
    @query = query
  end

  def perform
    search_by_categories
    search_by_tasks if collection.blank?
    collection
  end

  private

    def search_by_categories
      @collection = Category.by_search_in(query)
    end

    def search_by_tasks
      @collection = Category.by_search_in_tasks(query)
    end
end
