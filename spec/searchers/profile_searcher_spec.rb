describe Profile, search: true do
  let!(:user) { create(:user, :reindex, name: 'Алексей Иванов') }
  let!(:profile) { create(:profile, :reindex, user: user) }

  context 'search with a query param' do
    context 'a record exists in ES index' do
      context 'search by first name' do
        it 'checks a count of result' do
          results = ProfileSearch.new(query: 'Алексей').all.results
          expect(results.count).to eq 1
        end
      end

      context 'search by last_name' do
        it 'checks a count of result' do
          results = ProfileSearch.new(query: 'Иванов').all.results
          expect(results.count).to eq 1
        end
      end

      context 'search by full name name' do
        it 'checks a count of result' do
          results = ProfileSearch.new(query: 'Алексей Иванов').all.results
          expect(results.count).to eq 1
        end
      end
    end

    context 'a record does not exist in ES index' do
      it 'checks a zero count of result' do
        results = ProfileSearch.new(query: 'Петр').all.results
        expect(results.count).to eq 0
      end
    end
  end
end
