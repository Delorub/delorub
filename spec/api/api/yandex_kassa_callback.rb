require 'spec_helper'

describe Api::V10::YandexKassaCallback do
  context 'Api by yandex kassa callback' do
    it 'POST check value' do
      post '/api/billings/check'
      expect(response.status).to eq 201
    end

    it 'POST aviso value' do
      post '/api/billings/process'
      expect(response.status).to eq 201
    end
  end
end
