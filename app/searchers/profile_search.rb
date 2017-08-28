class ProfileSearch < BaseSearch
  private

  def searchkick_search
    Searchkick.search query,
      index_name: Profile,
      fields: [:user_name],
      match: :word_start,
      page: page,
      per_page: per_page
  end
end
