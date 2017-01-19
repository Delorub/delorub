module Billable::Task
  extend ActiveSupport::Concern

  included do
    validate :ensure_user_can_create
  end
  
  private

    def ensure_user_can_create
    end
end