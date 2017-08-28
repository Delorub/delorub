describe Admin::UsersController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:params) { FactoryGirl.attributes_for(:user) }
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
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: user.id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns users' do
      expect(assigns(:user)).to eq(user)
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
      post :create, params: { user: params }
      expect(response.status).to eq 200
    end
  end

  describe 'GET /admin/users/:id/permission' do
    def dispatch
      get :permission, params: { id: user.id }
    end

    it_behaves_like 'success response'

    context 'when admin have no access to permissions' do
      let(:permission) { create :user_permission, admin_user_view: true }
      let(:another_user) { create :user, permission: permission }

      before do
        sign_in another_user
        dispatch
      end

      it_behaves_like 'page not found response'
    end
  end

  describe 'PUT /admin/users/:id/permission' do
    let(:another_user) { create :user }
    let(:permission_attributes) { { superadmin: true } }

    def dispatch
      put :permission, params: { id: another_user.id, user_permission: permission_attributes }
    end

    subject { dispatch }

    it { is_expected.to redirect_to admin_user_path(another_user) }
    it do
      expect { subject }.to change { another_user.reload.permission.superadmin }.from(false).to(true)
    end
  end
end
