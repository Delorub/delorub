describe Reply do
  let(:reply) { build described_class }
  subject { reply }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:task) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:task) }
    it { is_expected.to belong_to(:billable) }
  end
end
