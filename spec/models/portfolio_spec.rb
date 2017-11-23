# == Schema Information
#
# Table name: portfolio_items
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  file         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#  deleted_at   :datetime
#
# Indexes
#
#  index_portfolio_items_on_portfolio_id  (portfolio_id)
#

describe Portfolio do
  let(:portfolio) { build :portfolio }
  subject { portfolio }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:profile) }
  end
end
