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

FactoryGirl.define do
  factory :sms_confirmation do
    sequence(:phone) { |n| Phony.format("7999#{1_234_567 + n}") }
  end
end
