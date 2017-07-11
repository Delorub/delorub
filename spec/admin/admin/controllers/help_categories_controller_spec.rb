describe Admin::HelpCategoriesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:help_category) { create :help_category }
  let(:params) { FactoryGirl.attributes_for(:help_category) }

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

    it 'assigns help_categories' do
      expect(assigns(:help_categories)).to eq([help_category])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: help_category.id }
    end

    it 'checks the redirect to help answers' do
      expect(response).to redirect_to admin_help_category_help_answers_path(help_category_id: help_category.id)
    end

    it 'assigns help_categories' do
      expect(assigns(:help_category)).to eq(help_category)
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
      post :create, params: { help_category: params }
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: help_category.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns help_categories' do
      expect(assigns(:help_category)).to eq(help_category)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: help_category.id, help_category: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: help_category.id }
      expect(response.status).to eq 302
    end
  end
end
