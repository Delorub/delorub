module Searchable::Profile
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:name], language: :russian

    scope :by_search_in, ->(q) {
      search_by_ids ProfileSearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in, :categories_id_eq]
    end
  end

  def search_data
    {
      name: name
    }
  end
end
