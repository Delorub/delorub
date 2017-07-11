# == Schema Information
#
# Table name: help_questions
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  content    :text
#  reply      :text
#  answered   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  replied_at :datetime
#

describe HelpQuestion do
  let(:help_question) { build :help_question }
  subject { help_question }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_least(8) }
  end
end
