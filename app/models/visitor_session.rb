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
# Indexes
#
#  index_visitor_sessions_on_city  (city)
#

class VisitorSession < ApplicationRecord
  scope :source_and_identity, ->(q) {
    action_type, identity = q.split('#')
    joins(:actions).where(visitor_session_actions: { action_type: action_type, identity: identity.to_s }).distinct
  }

  def self.ransackable_scopes auth_object = nil
    [:source_and_identity]
  end

  has_many :actions, class_name: 'VisitorSessionAction'
  has_many :coming_soon_requests
  has_one :coming_soon_request
end
