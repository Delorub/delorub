describe Admin::VacanciesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:vacancy) { create :vacancy }
  let(:params) { FactoryGirl.attributes_for(:vacancy) }

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

    it 'assigns vacancies' do
      expect(assigns(:vacancies)).to eq([vacancy])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: vacancy.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns vacancies' do
      expect(assigns(:vacancy)).to eq(vacancy)
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
      post :create, params: { vacancy: params }
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: vacancy.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns vacancies' do
      expect(assigns(:vacancy)).to eq(vacancy)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: vacancy.id, vacancy: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq(302)
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: vacancy.id }
      expect(response.status).to eq(302)
    end
  end
end
