module Searchable::Reply
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end