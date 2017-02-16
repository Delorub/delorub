module Searchable::Page
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end
