describe Specialization do
  let(:specialization) { build :specialization }
  subject { specialization }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
