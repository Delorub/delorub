# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string           not null
#  category_id        :integer          not null
#  user_id            :integer          not null
#  price_type         :string           not null
#  price_scale        :string
#  price_exact        :integer
#  price_from         :integer
#  price_to           :integer
#  place_id           :integer
#  place_lat          :float
#  place_long         :float
#  place_address      :string
#  date_type          :string           not null
#  contract_type      :string
#  description        :text
#  notify_email       :boolean
#  colored            :boolean          default(FALSE)
#  billable_type      :string
#  billable_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  date_actual        :datetime
#  date_interval_from :datetime
#  date_interval_to   :datetime
#  aasm_state         :string
#
# Indexes
#
#  index_tasks_on_aasm_state  (aasm_state)
#

FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| Faker::Commerce.department(1) }
    sequence(:description) { |n| Faker::Lorem.paragraph }

    price_type :exact
    date_type :start_at

    user
    category
  end
end
