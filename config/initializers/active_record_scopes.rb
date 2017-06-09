module SharedScopes
  extend ActiveSupport::Concern

  module ClassMethods
    def search_by_ids ids
      if ids.any?
        unscoped.where(id: ids)
      else
        none
      end
    end
  end
end

ActiveRecord::Base.send(:include, SharedScopes)
