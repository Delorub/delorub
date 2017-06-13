describe Category do
  let(:category) { build described_class }
  subject { category }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
