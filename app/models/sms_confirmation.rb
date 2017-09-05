# == Schema Information
#
# Table name: sms_confirmations
#
#  id           :integer          not null, primary key
#  token        :string
#  phone        :string
#  code         :string
#  accepted     :boolean          default(FALSE)
#  attempts     :integer          default(0)
#  last_sent_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SmsConfirmation < ApplicationRecord
  phony_normalize :phone
  phony_normalized_method :phone

  validates :phone, :token, :code, presence: true
end
