module Billing::Subscriptionable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where{ active_to > DateTime.now & active_from < DateTime.now } }

    validates :active_to, :active_from, presence: true
  end
end
