describe YandexKassaCallbackController, type: :controller do
  describe 'Yandex Kassa check' do
    it 'return success' do
      post :check
      expect(response.status).to eq(200)
    end
  end
  describe 'Yandex Kassa process' do
    it 'return success' do
      post :processing
      expect(response.status).to eq(200)
    end
  end
end
