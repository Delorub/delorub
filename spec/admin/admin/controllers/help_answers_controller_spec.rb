describe Admin::HelpAnswersController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:help_answer) { create :help_answer }
  let(:help_category_id) { help_answer.help_category.id }
  let(:params) { FactoryGirl.attributes_for(:help_answer) }

  subject { response }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before :each do
      get :index, params: { help_category_id: help_category_id }
    end

    it 'checks the status' do
      expect(response.status).to eq(200)
    end

    it 'assigns help_answers' do
      expect(assigns(:help_answers)).to eq([help_answer])
    end
  end

  describe 'GET #new' do
    it 'checks the status' do
      get :new, params: { help_category_id: help_category_id }
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    it 'checks the redirect status' do
      post :create, params: { help_category_id: help_category_id, help_answer: params }
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { help_category_id: help_category_id, id: help_answer.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns help_answers' do
      expect(assigns(:help_answer)).to eq(help_answer)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { help_category_id: help_category_id, id: help_answer.id, help_answer: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { help_category_id: help_category_id, id: help_answer.id }
      expect(response.status).to eq 302
    end
  end
end
