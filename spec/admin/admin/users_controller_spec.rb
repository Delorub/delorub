describe Admin::UsersController, type: :controller do
  render_views

  let(:user) { create :admin }
  subject { response }

  before do
    sign_in user
  end

  describe 'GET /admin/users' do
    let(:another_user) { create :admin }

    def dispatch
      get :index
    end

    it_behaves_like 'success response'
  end

  describe 'GET /admin/users/:id' do
    let(:another_user) { create :admin }

    def dispatch
      get :show, id: another_user.id
    end

    it_behaves_like 'success response'
  end

  describe 'GET /admin/users/:id/permission' do
    def dispatch
      get :permission, id: user.id
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
      put :permission, id: another_user.id, user_permission: permission_attributes
    end

    subject { dispatch }

    it { is_expected.to redirect_to admin_user_path(another_user) }
    it do
      expect { subject }.to change { another_user.reload.permission.superadmin }.from(false).to(true)
    end
  end
end
