module Billing::Packable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(avaiable: true) }

    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :spent, presence: true, numericality: { less_than_or_equal_to: :amount }

    before_save :update_availability
  end
  
  def increase_spent
    increase(:amount)
    save!
  end
  
  private
  
    def update_availability
      available = !(spent == amount)
    end
end
