class HelpAnswerSearch < BaseSearch
  private

    def searchkick_search
      Searchkick.search query,
        index_name: HelpAnswer,
        fields: ['title^10', 'content^5', 'synonyms^7', 'category'],
        match: :word_start,
        page: @page,
        per_page: @per_page
    end
end
