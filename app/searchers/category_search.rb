class CategorySearch < BaseSearch
  private

    def searchkick_search
      Searchkick.search query,
        fields: [:title, :tasks_title],
        index_name: Category,
        match: :word_start,
        page: page,
        per_page: per_page
    end
end
