module Searchable::Task
  extend ActiveSupport::Concern

  included do
    searchkick
  end
end