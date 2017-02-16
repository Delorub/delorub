describe Place do
  let(:place) { build :place }
  subject { place }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
