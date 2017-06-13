describe Contract do
  let(:contract) { build described_class }
  subject { contract }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:template) }
  end
end
