# == Schema Information
#
# Table name: coming_soon_requests
#
#  id                 :integer          not null, primary key
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  visitor_session_id :integer
#

class ComingSoonRequest < ApplicationRecord
  belongs_to :visitor_session
end
