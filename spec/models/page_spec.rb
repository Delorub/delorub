# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  content    :text
#  draft      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Page do
  let(:page) { build :page }
  subject { page }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end
