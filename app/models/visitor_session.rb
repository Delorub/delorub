# == Schema Information
#
# Table name: visitor_sessions
#
#  id         :integer          not null, primary key
#  ip         :string
#  city       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VisitorSession < ApplicationRecord
  has_many :actions, class_name: 'VisitorSessionAction'
end
