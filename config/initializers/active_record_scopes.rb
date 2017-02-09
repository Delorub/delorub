module SharedScopes
  extend ActiveSupport::Concern

  module ClassMethods
    def by_search_ids ids
      if ids.any?
        unscoped.where(id: ids).order("field(id, #{ids.join(',')})")
      else
        none
      end
    end
  end
end

ActiveRecord::Base.send(:include, SharedScopes)