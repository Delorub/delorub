# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  file       :string
#  profile_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_certificates_on_profile_id  (profile_id)
#

describe Certificate do
  let(:portfolio_item) { build :portfolio_item }
  subject { portfolio_item }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:file) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:profile) }
  end
end
