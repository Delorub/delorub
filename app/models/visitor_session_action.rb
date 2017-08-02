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
#  index_visitor_session_actions_on_action_type               (action_type)
#  index_visitor_session_actions_on_identity_and_action_type  (identity,action_type)
#  index_visitor_session_actions_on_visitor_session_id        (visitor_session_id)
#  index_vsa_on_keyword_and_identity_and_action_type          (keyword,identity,action_type)
#

class VisitorSessionAction < ApplicationRecord
  extend Enumerize

  belongs_to :session, class_name: 'VisitorSession', foreign_key: 'visitor_session_id', inverse_of: :actions

  serialize :data

  enumerize :action_type, in: [:internal_link, :global_referer, :yandex_direct, :utm_source, :post_form]
end
