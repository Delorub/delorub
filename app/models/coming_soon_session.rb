# == Schema Information
#
# Table name: coming_soon_sessions
#
#  id           :integer          not null, primary key
#  source       :string
#  source_data  :string
#  action_type  :string
#  form_keyword :string
#  city         :string
#  referer      :string
#  email        :string
#  ip           :string
#  visited_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  utm_data     :text
#

class ComingSoonSession < ApplicationRecord
  serialize :utm_data
end
