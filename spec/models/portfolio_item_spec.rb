# == Schema Information
#
# Table name: portfolio_items
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_portfolio_items_on_profile_id  (profile_id)
#

describe PortfolioItem do
  let(:portfolio_item) { build :portfolio_item }
  subject { portfolio_item }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:file) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to have_many(:comments) }
  end
end
