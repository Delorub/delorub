class CategorySearch < BaseSearch
  private

    def searchkick_search
      Searchkick.search query,
        index_name: Category,
        match: :word_start,
        page: page,
        per_page: per_page
    end
end
