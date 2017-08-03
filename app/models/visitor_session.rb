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
  MAIN_CITY_NAMES = ['Москва', 'Санкт-Петербург', 'Екатеринбург', 'Новосибирск'].freeze

  scope :custom_city, ->(city) {
    if city == '#other#'
      where.not(city: MAIN_CITY_NAMES).or(where(city: nil))
    else
      where(city: city)
    end
  }

  scope :source_and_identity, ->(q) {
    action_type, identity = q.split('#')
    return_scope = joins(:actions).where(visitor_session_actions: { action_type: action_type }).distinct
    return_scope = return_scope.where(visitor_session_actions: { identity: identity.to_s }) if identity.present?
    return_scope
  }

  def self.ransackable_scopes auth_object = nil
    [:source_and_identity, :custom_city]
  end

  has_many :actions, class_name: 'VisitorSessionAction'
  has_many :coming_soon_requests
  has_one :coming_soon_request
end
