module Billing::Base
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_one :user_billing

    validates :user, presence: true
  end
end
