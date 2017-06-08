describe Admin::CategoriesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:category) { create :category }
  let(:params) { FactoryGirl.attributes_for(:category) }

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

    it 'assigns categories' do
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, id: category.slug
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns categories' do
      expect(assigns(:category)).to eq(category)
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
      post :create, category: params
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, id: category.slug
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns categories' do
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, id: category.slug, category: params
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, id: category.slug
      expect(response.status).to eq 302
    end
  end
end
