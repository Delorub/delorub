# == Schema Information
#
# Table name: contracts
#
#  id          :integer          not null, primary key
#  template_id :integer
#  data        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

describe Contract do
  let(:contract) { build :contract }
  subject { contract }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:template) }
  end
end
