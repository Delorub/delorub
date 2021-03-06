# == Schema Information
#
# Table name: help_answers
#
#  id               :integer          not null, primary key
#  help_category_id :integer
#  title            :string
#  content          :text
#  synonyms         :text
#  position         :integer
#

describe HelpAnswer do
  let(:help_answer) { build :help_answer }
  subject { help_answer }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:help_category) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:help_category) }
  end
end
