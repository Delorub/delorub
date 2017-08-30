RSpec.describe CategoriesController, type: :controller do
  describe 'GET index' do
    let(:category) { create :category }

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq([category])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response.status).to eq 200
    end
  end
end
