describe Task do
  let(:task) { build :task }
  subject { task }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
