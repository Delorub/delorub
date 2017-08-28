module Searchable::User
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:name, :email], language: :russian

    scope :by_search_in, ->(q) {
      search_by_ids UserSearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
    }

    def self.ransackable_scopes auth_object = nil
      [:by_search_in]
    end
  end

  def search_data
    {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end
end
