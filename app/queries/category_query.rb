class CategoryQuery
  attr_accessor :collection, :search_params

  def initialize collection: nil, search_params:
    @collection = collection
    @search_params = search_params
  end

  def search
    search_by_categories
    parse_collection
  end

  private

    def search_by_categories
      @collection = Category.by_search_in(search_params)
    end

    def parse_collection
      @collection = @collection.map{ |a| { id: a.id, title: a.title } }
    end
end
