class Reply < ActiveRecord::Base
  include Searchable::Reply
  include Billable::Reply
  
  belongs_to :task
  belongs_to :user
  belongs_to :billable, polymorphic: true
  
  validates :user, :task, presence: true
end
