module Billing::Subscriptionable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where{ active_to > DateTime.current && active_from < DateTime.current } }

    validates :active_to, :active_from, presence: true
  end
end
