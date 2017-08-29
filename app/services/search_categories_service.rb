class SearchCategoriesService
  attr_reader :search_params, :collection

  def initialize params:
    @search_params = params[:search]
  end

  def perform
    search_by_categories
    search_by_tasks if @collection.blank?
    @collection
  end

  private

    def search_by_categories
      @collection = Category.by_search_in(search_params)
    end

    def search_by_tasks
      @collection = Category.by_search_in_tasks(search_params)
    end
end
