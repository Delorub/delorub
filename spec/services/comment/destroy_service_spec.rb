describe Comment::DestroyService do
  let!(:parent_comment) { create(:comment) }
  let!(:child_comment) { create(:comment, parent_id: parent_comment.id) }

  context 'foreign keys after deleting' do
    it 'checks existing foreign key' do
      expect(child_comment.parent_id).to eq parent_comment.id
    end

    # it 'checks that foreign key of child is nil' do
    #  service = described_class.new(parent_comment).perform
    #  expect { service }.to change(Comment, :count).by(-1)
    #  expect { service }.to change(child_comment, :count).by(nil)
    # end
  end
end
