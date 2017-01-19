class Specialization < ActiveRecord::Base
  belongs_to :profile
  belongs_to :category
  
  validates :profile, :category, presence: true
end
