describe Admin::PortfoliosController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:portfolio) { create :portfolio }
  let(:params) { FactoryGirl.attributes_for(:portfolio) }

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

    it 'assigns portfolio items' do
      expect(assigns(:portfolios)).to eq([portfolio])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: portfolio.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:portfolio)).to eq(portfolio)
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
      post :create, params: { portfolio: params }
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: portfolio.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:portfolio)).to eq(portfolio)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: portfolio.id, portfolio: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: portfolio.id }
      expect(response.status).to eq 302
    end
  end
end
