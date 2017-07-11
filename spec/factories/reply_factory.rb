# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  task_id       :integer
#  user_id       :integer
#  status        :string
#  content       :text
#  billable_type :string
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  aasm_state    :string
#
# Indexes
#
#  index_replies_on_aasm_state  (aasm_state)
#

FactoryGirl.define do
  factory :reply do
    task
    user
    content Faker::Lorem.sentences(2)
  end
end
