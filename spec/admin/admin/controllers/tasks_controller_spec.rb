describe Admin::TasksController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:task) { create :task }
  let(:params) { FactoryGirl.attributes_for(:task) }

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

    it 'assigns tasks' do
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: task.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns tasks' do
      expect(assigns(:task)).to eq(task)
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
      post :create, params: { task: params }
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: task.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns tasks' do
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: task.id }
      expect(response.status).to eq 302
    end
  end
end
