describe Profile::PlaceValidator do
  let(:city) { create(:city_place) }
  let(:district) { create(:district_place) }
  let(:profile) { build(:profile) }
  let(:validator) { described_class }

  subject { validator.new.validate(profile) }

  context 'place is a city' do
    before :each do
      profile.place_id = city.id
    end

    it 'checks a validness' do
      expect(profile.valid?).to eq true
    end

    it 'checks that errors array is empty' do
      expect(is_expected.target).to be_nil
    end
  end

  context 'place is not a city' do
    before :each do
      profile.place_id = district.id
    end

    it 'checks a validness' do
      expect(profile.valid?).to eq false
    end

    it 'checks that errors array is empty' do
      expect(is_expected.target).to include 'must be a city'
    end
  end
end
