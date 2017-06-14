describe Place do
  let(:place) { build described_class }
  subject { place }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:place_type_name) }
    it { is_expected.to belong_to(:parent_place) }
    it { is_expected.to belong_to(:region_place) }
  end
end
