describe Api::V10::PortfolioItems do
  include Rack::Test::Methods
  include RequestSpecHelper

  let(:user) { create(:user) }
  let(:portfolio_item) { create(:portfolio_item) }
  let(:comment_of_user) { create(:comment, commentable: portfolio_item, user: user, text: 'Text') }
  let(:another_comment) { create(:comment, commentable: portfolio_item) }
  let(:body) { { text: 'Text' } }

  describe 'Comments resource' do
    describe 'GET /api/portfolio_items/:id/comments' do
      let(:expected_response) { Comment.all.to_json }

      it 'returns 200' do
        get "/api/portfolio_items/#{portfolio_item.id}/comments"
        expect(last_response.status).to eq 200
      end

      it 'checks all comments of portfolio item' do
        get "/api/portfolio_items/#{portfolio_item.id}/comments"
        expect(last_response.body).to eq(expected_response)
      end
    end

    describe 'POST /api/portfolio_items/:id/comments' do
      context 'not authenticated user' do
        it 'returns 401' do
          post "/api/portfolio_items/#{portfolio_item.id}/comments", body
          expect(last_response.status).to eq 401
        end
      end

      context 'authenticated user' do
        before :each do
          send_access_token user.access_token
        end

        it 'returns 201 code' do
          post "/api/portfolio_items/#{portfolio_item.id}/comments", body
          expect(last_response.status).to eq 201
        end

        it 'checks a returned object after creating' do
          post "/api/portfolio_items/#{portfolio_item.id}/comments", body
          comment = Comment.last.to_json
          expect(last_response.body).to eq comment
        end
      end
    end

    describe 'PATCH /api/portfolio_items/:id/comments/:comment_id' do
      context 'not authenticated user' do
        it 'returns 401' do
          patch "/api/portfolio_items/#{portfolio_item.id}/comments/#{comment_of_user.id}", body
          expect(last_response.status).to eq 401
        end
      end

      context 'authenticated user' do
        before :each do
          send_access_token user.access_token
        end

        context 'if not owner' do
          it 'returns 403' do
            patch "/api/portfolio_items/#{portfolio_item.id}/comments/#{another_comment.id}", body
            expect(last_response.status).to eq 403
          end
        end

        context 'if owner' do
          it 'returns 200' do
            patch "/api/portfolio_items/#{portfolio_item.id}/comments/#{comment_of_user.id}", body
            expect(last_response.status).to eq 200
          end

          it 'checks a changed value after updating' do
            patch "/api/portfolio_items/#{portfolio_item.id}/comments/#{comment_of_user.id}", text: 'New Text'
            expect(JSON.parse(last_response.body)['text']).to eq 'New Text'
          end
        end
      end
    end
  end
end
