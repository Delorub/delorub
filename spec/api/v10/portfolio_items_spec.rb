describe Api::V10::PortfolioItems do
  include Rack::Test::Methods

  let(:user) { create(:user) }
  let(:portfolio_item) { create(:portfolio_item) }
  let(:comment) { create(:comment, commentable: portfolio_item, user: user) }
  let(:another_comment) { create(:comment, commentable: portfolio_item) }

  describe 'GET /api/portfolio_items/:id/comments' do
    let(:expected_response) { Comment.all.to_json }

    it 'returns all comments of portfolio item' do
      get "/api/portfolio_items/#{portfolio_item.id}/comments"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(expected_response)
    end
  end
end
