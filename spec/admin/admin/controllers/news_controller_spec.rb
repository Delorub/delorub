describe Admin::NewsController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:news) { create :news }
  let(:params) { FactoryGirl.attributes_for(:news) }

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

    it 'assigns news' do
      expect(assigns(:news)).to eq([news])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, id: news.id
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns news' do
      expect(assigns(:news)).to eq(news)
    end
  end

  describe 'GET #new' do
    it 'checks the status' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    it 'checks the redirect status' do
      post :create, news: params
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, id: news.id
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns news' do
      expect(assigns(:news)).to eq(news)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, id: news.id, news: params
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, id: news.id
      expect(response.status).to eq 302
    end
  end
end
