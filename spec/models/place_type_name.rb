describe PlaceTypeName do
  let(:place_type_name) { build :place_type_name }
  subject { place_type_name }

  describe 'validations' do
    it { is_expected.to be_valid }
  end
end
