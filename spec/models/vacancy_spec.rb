# == Schema Information
#
# Table name: vacancies
#
#  id                :integer          not null, primary key
#  title             :string
#  small_description :text
#  description       :text
#  position          :integer
#  archive           :boolean          default(FALSE)
#

describe Vacancy do
  let(:vacancy) { build :vacancy }
  subject { vacancy }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:small_description) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
