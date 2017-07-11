describe Admin::HelpQuestionsController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:help_question) { create :help_question }
  let(:params) { FactoryGirl.attributes_for(:help_question) }

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

    it 'assigns help_questions' do
      expect(assigns(:help_questions)).to eq([help_question])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: help_question.id }
    end

    it 'checks the status redirect' do
      expect(response.status).to eq(200)
    end

    it 'assigns help_questions' do
      expect(assigns(:help_question)).to eq(help_question)
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: help_question.id }
      expect(response.status).to eq 302
    end
  end
end
