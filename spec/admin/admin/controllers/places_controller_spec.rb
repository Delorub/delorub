describe Admin::PlacesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:place) { create :street_place }

  subject { response }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns places' do
      expect(assigns(:places)).to eq([place])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, id: place.id
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns places' do
      expect(assigns(:place)).to eq(place)
    end
  end
end
