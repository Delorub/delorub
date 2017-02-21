describe Admin::PlacesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:place) { create :street_place }

  subject { response }

  before do
    sign_in user
  end

  describe 'GET /admin/places' do
    def dispatch
      get :index
    end

    it_behaves_like 'success response'
  end

  describe 'GET /admin/places/:id' do
    def dispatch
      get :show, id: place.id
    end

    it_behaves_like 'success response'
  end
end
