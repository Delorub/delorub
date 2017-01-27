class Task < ActiveRecord::Base
  include Searchable::Task
  include Billable::Task

  extend Enumerize
  
  belongs_to :user
  belongs_to :category
  belongs_to :billable, polymorphic: true

  enumerize :price_type, in: [:exact, :interval, :scale]
  enumerize :date_type, in: [:actual, :interval]
  
  validates :user, :category, :price_type, :date_type, presence: true
end
