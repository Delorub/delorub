# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  parent_id        :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  text             :text
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_user_id                              (user_id)
#

describe Comment do
  let(:comment) { build :comment }
  subject { comment }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:commentable_id) }
    it { is_expected.to validate_presence_of(:commentable_type) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(1000) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to have_many(:comments) }
  end
end
