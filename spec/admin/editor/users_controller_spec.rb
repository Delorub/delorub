describe Editor::UsersController, type: :controller do
  render_views

  let(:user) { create :editor }
  subject { response }

  before do
    sign_in user
  end

  describe 'GET /editor/users' do
    let(:another_user) { create :admin }

    def dispatch
      get :index
    end

    it_behaves_like 'success response'
  end

  describe 'GET /editor/users/:id' do
    let(:another_user) { create :admin }

    def dispatch
      get :show, id: another_user.id
    end

    it_behaves_like 'success response'
  end

  describe 'GET /editor/users/:id/permission' do
    def dispatch
      get :permission, id: user.id
    end

    it_behaves_like 'success response'

    context 'when editor have no access to permissions' do
      let(:permission) { create :user_permission, editor_user_view: true }
      let(:another_user) { create :user, permission: permission }

      before do
        sign_in another_user
        dispatch
      end

      it_behaves_like 'page not found response'
    end
  end

  describe 'PUT /editor/users/:id/permission' do
    let(:another_user) { create :user }

    def dispatch
      put :permission, id: another_user.id, user_permission: permission_attributes
    end

    subject { dispatch }

    context 'when updating editor permissions' do
      let(:permission_attributes) { { editor_user: true } }

      it { is_expected.to redirect_to editor_user_path(another_user) }
      it do
        expect { subject }.to change { another_user.reload.permission.editor_user }.from(false).to(true)
      end
    end

    context 'when updating superadmin permissions' do
      let(:permission_attributes) { { superadmin: true } }

      it { is_expected.to redirect_to editor_user_path(another_user) }
      it do
        expect { subject }.not_to change { another_user.reload.permission.superadmin }
      end
    end
  end
end
