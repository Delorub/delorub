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
#  city_id            :integer
#
# Indexes
#
#  index_tasks_on_aasm_state  (aasm_state)
#  index_tasks_on_city_id     (city_id)
#

describe Task do
  let(:task) { build :task }
  subject { task }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:price_type) }
    it { is_expected.to validate_presence_of(:date_type) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:billable) }
  end
end
