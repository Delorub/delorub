# == Schema Information
#
# Table name: visitor_session_actions
#
#  id                 :integer          not null, primary key
#  visitor_session_id :integer
#  action_type        :string
#  identity           :string
#  keyword            :string
#  url                :string
#  data               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_visitor_session_actions_on_visitor_session_id  (visitor_session_id)
#

class VisitorSessionAction < ApplicationRecord
  belongs_to :session, class_name: 'VisitorSession', foreign_key: 'visitor_session_id', inverse_of: :actions

  serialize :data
end
