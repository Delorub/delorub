module Searchable::Category
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title], language: :russian

    scope :by_search_in, ->(q) {
      search_by_ids CategorySearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
    }

    scope :by_search_in_tasks, ->(q) {
      search_by_ids TaskCategoriesSearch.new(query: q, page: 1, per_page: 100).categories_ids
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end
  end
end
