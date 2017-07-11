describe Admin::ContractTemplatesController, type: :controller do
  render_views

  let(:user) { create :admin }
  let(:contract_template) { create :contract_template }
  let(:params) { FactoryGirl.attributes_for(:contract_template) }

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

    it 'assigns contract_templates' do
      expect(assigns(:contract_templates)).to eq([contract_template])
    end
  end

  describe 'GET #show' do
    before :each do
      get :show, params: { id: contract_template.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns contract_templates' do
      expect(assigns(:contract_template)).to eq(contract_template)
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
      post :create, params: { contract_template: params }
      expect(response.status).to eq 302
    end
  end

  describe 'GET #edit' do
    before :each do
      get :edit, params: { id: contract_template.id }
    end

    it 'checks the status' do
      expect(response.status).to eq 200
    end

    it 'assigns contract_templates' do
      expect(assigns(:contract_template)).to eq(contract_template)
    end
  end

  describe 'PATCH #update' do
    before :each do
      patch :update, params: { id: contract_template.id, contract_template: params }
    end

    it 'checks the redirect status' do
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'checks the status' do
      delete :destroy, params: { id: contract_template.id }
      expect(response.status).to eq 302
    end
  end
end
