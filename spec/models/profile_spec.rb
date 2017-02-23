describe Profile do
  let(:profile) { build :profile }
  subject { profile }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
