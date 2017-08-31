class TaskCategoriesSearch < BaseSearch
  def categories_ids
    searchkick_search.aggs['category_id']['buckets'].map { |a| a['key'] }
  end

  private

  def searchkick_search
    Searchkick.search query,
      fields: [:title],
      index_name: Task,
      match: :word_start,
      page: page,
      per_page: per_page,
      aggs: [:category_id]
  end
end
