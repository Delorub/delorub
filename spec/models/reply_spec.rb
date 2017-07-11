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

describe Reply do
  let(:reply) { build :reply }
  subject { reply }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:task) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:task) }
    it { is_expected.to belong_to(:billable) }
  end
end
