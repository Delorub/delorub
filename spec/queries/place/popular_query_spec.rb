describe Place::PopularQuery do
  let!(:city1) { create(:city_place) }
  let!(:city2) { create(:city_place) }
  let(:city_of_profile) { create(:city_place) }
  let(:profile) { create(:profile, place: city_of_profile) }

  it 'checks that city of user first in an array' do
    result = described_class.new(profile).perform
    expect(result.first).to eq city_of_profile
  end
end
