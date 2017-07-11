describe Admin::PagesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:page) { create :page }
  let(:params) { FactoryGirl.attributes_for(:page) }

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

    it 'assigns pages' do
      expect(assigns(:pages)).to eq([page])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: page.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns pages' do
      expect(assigns(:page)).to eq(page)
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
      post :create, params: { page: params }
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: page.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns pages' do
      expect(assigns(:page)).to eq(page)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: page.id, page: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq(302)
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: page.id }
      expect(response.status).to eq(302)
    end
  end
end
