describe Comment do
  let(:comment) { build described_class }
  subject { comment }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:commentable_id) }
    it { is_expected.to validate_presence_of(:commentable_type) }
    it { is_expected.to validate_presence_of(:text) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:parent) }
  end
end
