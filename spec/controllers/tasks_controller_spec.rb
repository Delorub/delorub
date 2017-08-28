require 'spec_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET /new' do
    it 'returns a success response' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    let(:task) { FactoryGirl.create :task }

    it 'returns a success response' do
      get :show, params: { id: task.id }
      expect(response.status).to eq 200
    end

    it 'returns not found' do
      get :show, params: { id: 'not_existing_page' }
      expect(response.status).to eq 404
    end
  end
end
