describe Place::PopularQuery do
  let!(:city1) { create(:city_place) }
  let!(:city2) { create(:city_place) }
  let(:city_of_user) { create(:city_place) }
  let(:user) { create(:user, place: city_of_user) }

  it 'checks that city of user first in an array' do
    result = described_class.new(user).perform
    expect(result.first).to eq city_of_user
  end
end
