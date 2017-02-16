describe Page do
  let(:page) { build :page }
  subject { page }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
