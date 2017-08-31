require 'spec_helper'

describe Api::V10::Categories do
  context 'Api category' do
    it 'POST search category' do
      post '/api/categories', params: { query: 'тест' }
      expect(response.status).to eq 201
    end
  end
end
