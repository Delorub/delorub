module Searchable::Task
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title], language: :russian

    scope :by_search_in, ->(q) {
      ids = TaskSearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
      where(id: ids)
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end
  end
end
