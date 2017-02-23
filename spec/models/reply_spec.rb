describe Reply do
  let(:reply) { build :reply }
  subject { reply }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
