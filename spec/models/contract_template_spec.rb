# == Schema Information
#
# Table name: contract_templates
#
#  id          :integer          not null, primary key
#  title       :string
#  category_id :integer
#  markup      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

describe ContractTemplate do
  let(:contract_template) { build :contract_template }
  subject { contract_template }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:category) }
  end
end
