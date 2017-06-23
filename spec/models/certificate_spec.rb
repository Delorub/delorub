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
