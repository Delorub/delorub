describe Place, search: true do
  let!(:region_place) { create(:region_place, :reindex) }
  let!(:district_place) { create(:district_place, :reindex) }
  let!(:city_place) { create(:city_place,
                             :reindex,
                             name: 'Санкт-Петербург',
                             place_type: :city) }
  let!(:locality_place) { create(:locality_place, :reindex) }
  let!(:street_place) { create(:street_place, :reindex) }
  let!(:house_place) { create(:house_place, :reindex) }

  context 'search with a query param' do
    context 'a record exists in ES index' do
      it 'checks a count and object of result' do
        results = PlaceSearch.new(query: 'Санкт').all.results
        expect(results.count).to eq 1
        expect(results.first).to eq city_place
      end
    end

    context 'a record does not exist in ES index' do
      it 'checks a zero count of result' do
        results = PlaceSearch.new(query: 'Москва').all.results
        expect(results.count).to eq 0
      end
    end
  end

  context 'search if the city param sends' do
    let(:results) { PlaceSearch.new(query: '*', type: 'city').all.results }

    it 'checks that filters by four types(region, district, city, locality)' do
      expect(results.count).to eq 4
    end

    it 'checks that street and house types are skipped in a search result' do
      types = results.map(&:place_type)
      expect(types).not_to include('street')
      expect(types).not_to include('house')
    end
  end
end
