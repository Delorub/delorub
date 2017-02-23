describe Service do
  let(:service) { build :service }
  subject { service }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
