describe Admin::CategoriesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:category) { create :category }

  subject { response }

  before do
    sign_in user
  end

  describe 'GET /admin/categories' do
    def dispatch
      get :index
    end

    it_behaves_like 'success response'
  end

  describe 'GET /admin/categories/:id' do
    def dispatch
      get :show, id: category.id
    end

    it_behaves_like 'success response'
  end
end
