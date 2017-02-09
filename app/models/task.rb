class Task < ActiveRecord::Base
  include Searchable::Task

  extend Enumerize
  
  belongs_to :user
  belongs_to :category
  belongs_to :billable, polymorphic: true

  enumerize :price_type, in: [:exact, :interval, :scale]
  enumerize :date_type, in: [:actual, :interval]
  
  validates :title, :description, :user, :category, :price_type, :date_type, presence: true
  validate :ensure_user_can_create

  after_create :update_user

  private

    def ensure_user_can_create
      if !self.new_record? && self.user && self.user.can_post_task?
        errors.add(:user, 'cannot create tasks')
      end
    end

    def update_user
      
    end
end
