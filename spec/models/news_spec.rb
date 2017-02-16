describe News do
  let(:news) { build :news }
  subject { news }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
