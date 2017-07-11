# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  message         :string
#  state           :string
#  params          :text
#  notifiable_type :string
#  notifiable_id   :integer
#  read_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    message { Faker::Lorem.word }
    state { Faker::Lorem.word }
    association :user, factory: :user
    params { Faker::Lorem.words }
    notifiable_type User
    notifiable_id 1
  end
end
