describe Grape::AuthHelpers do
  let(:user) { create :user }

  before :each do
    cookies.delete :access_token
    include described_class
  end

  context 'wrong cookie' do
    it 'checks a denied' do
      cookies[:access_token] = '111'
      expect(current_user).to be_nil
    end
  end

  context 'right cookie' do
    it 'checks an access' do
      cookies[:access_token] = user.access_token
      expect(current_user).to eq(user)
    end
  end
end
