module Searchable::Task
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title], language: :russian

    scope :by_search_in, ->(q) {
      ids = Task.new(query: q, page: 1, per_page: 100).all.map(&:id)
      where(id: ids)
    }

    scope :category, ->(q) {
      CategorySearch.new(query: q).all
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in, :category]
    end
  end
end
