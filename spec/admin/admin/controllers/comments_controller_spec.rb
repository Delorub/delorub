describe Admin::CommentsController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:comment) { create :comment }
  let(:params) { FactoryGirl.attributes_for(:comment) }

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

    it 'assigns portfolio items' do
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: comment.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:comment)).to eq(comment)
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
      post :create, params: { comment: params }
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: comment.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns portfolio items' do
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: comment.id, comment: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: comment.id }
      expect(response.status).to eq 302
    end
  end
end
