# == Schema Information
#
# Table name: specializations
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Specialization < ActiveRecord::Base
  belongs_to :profile
  belongs_to :category

  validates :profile, :category, presence: true
end
