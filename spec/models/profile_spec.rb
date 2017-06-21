describe Profile do
  let(:profile) { build :profile }
  subject { profile }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_and_belong_to_many(:categories) }
  end
end
