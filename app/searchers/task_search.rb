class TaskSearch < BaseSearch
  private

  def searchkick_search
    Searchkick.search query,
      fields: [:title],
      index_name: Task,
      match: :word_start,
      page: page,
      per_page: per_page
  end
end
