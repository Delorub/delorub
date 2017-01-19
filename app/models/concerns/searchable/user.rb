module Searchable::User
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end