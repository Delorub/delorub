module Searchable::Category
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end