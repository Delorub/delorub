# == Schema Information
#
# Table name: help_categories
#
#  id       :integer          not null, primary key
#  title    :string
#  position :integer
#

describe HelpCategory do
  let(:help_category) { build :help_category }
  subject { help_category }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:help_answers) }
  end
end
