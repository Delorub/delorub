describe News do
  let(:news) { build described_class }
  subject { news }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end
end
