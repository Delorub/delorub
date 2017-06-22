describe Admin::PortfolioItemsController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:portfolio_item) { create :portfolio_item }
  let(:params) { FactoryGirl.attributes_for(:portfolio_item) }

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
      expect(assigns(:portfolio_items)).to eq([portfolio_item])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, id: portfolio_item.id
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:portfolio_item)).to eq(portfolio_item)
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
      post :create, portfolio_item: params
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, id: portfolio_item.id
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:portfolio_item)).to eq(portfolio_item)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, id: portfolio_item.id, portfolio_item: params
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, id: portfolio_item.id
      expect(response.status).to eq 302
    end
  end
end
