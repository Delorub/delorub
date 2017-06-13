describe ContractTemplate do
  let(:contract_template) { build described_class }
  subject { contract_template }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:category) }
  end
end
