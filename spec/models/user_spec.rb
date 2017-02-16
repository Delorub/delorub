describe User do
  let(:user) { build :user }
  subject { user }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'permissions' do

  end
end
