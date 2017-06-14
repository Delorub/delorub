describe Service do
  let(:service) { build described_class }
  subject { service }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:profile) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:profile) }
  end
end
