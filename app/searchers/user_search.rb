class UserSearch < BaseSearch
  private

    def searchkick_search
      Searchkick.search query,
        fields: [:name, :email],
        index_name: User,
        match: :word_start,
        page: page,
        per_page: per_page
    end
end
