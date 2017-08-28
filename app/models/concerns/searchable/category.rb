module Searchable::Category
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:title, :tasks_title], language: :russian

    scope :by_search_in, ->(q) {
      search_by_ids CategorySearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end

    def search_data
      attributes.merge(
        tasks_title: tasks.map(&:title)
      )
    end
  end
end
