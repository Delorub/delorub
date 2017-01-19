module Billing::Subscriptionable
  extend ActiveSupport::Concern

  included do
    validates :active_to, :active_from, presence: true
  end
end