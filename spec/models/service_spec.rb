# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  price      :integer
#  price_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Service do
  let(:service) { build :service }
  subject { service }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:profile) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:profile) }
  end
end
