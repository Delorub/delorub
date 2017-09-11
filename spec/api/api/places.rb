require 'spec_helper'

describe Api::V10::Places do
  context 'Api by places' do
    it 'POST search by region' do
      post '/api/regions', params: { query: 'тест' }
      expect(response.status).to eq 201
    end

    it 'POST search by city' do
      post '/api/regions', params: { query: 'тест' }
      expect(response.status).to eq 201
    end
  end
end
