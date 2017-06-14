describe Vacancy do
  let(:vacancy) { build described_class }
  subject { vacancy }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:small_description) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
