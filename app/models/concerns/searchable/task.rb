module Searchable::Task
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title], language: :russian

    scope :by_search_in, ->(q) {
      search_by_ids TaskSearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
    }

    scope :search_include_categories, ->(q) {
      TaskSearch.new(query: q, page: 1,
                     per_page: 100, aggs: [:category_id]).all.aggs['category_id']['buckets'].map { |a| a['key'] }
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end
  end
end
