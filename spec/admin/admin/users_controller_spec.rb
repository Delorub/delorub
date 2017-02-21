describe Admin::UsersController, type: :controller do
  render_views

  let(:user) { create :admin }
  subject { response }

  before do
    sign_in user
    dispatch
  end

  describe 'GET /editor/users' do
    def dispatch
      get :index
    end

    it_behaves_like 'success response'
  end
end
