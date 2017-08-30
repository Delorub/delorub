class TaskCategoriesSearch < BaseSearch
  private

  def searchkick_search
    result = Searchkick.search query,
      fields: [:title],
      index_name: Task,
      match: :word_start,
      page: page,
      per_page: per_page,
      aggs: aggs
    result.aggs['category_id']['buckets'].map { |a| a['key'] }
  end
end
