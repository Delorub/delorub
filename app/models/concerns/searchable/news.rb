module Searchable::News
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end