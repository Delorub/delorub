# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  about              :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  price_project      :integer
#  rating_votes_count :integer
#  rating_votes_sum   :integer
#  rating             :float
#  birthday           :date
#  city_name          :string
#  city_id            :integer
#
# Indexes
#
#  index_profiles_on_city_id  (city_id)
#

describe Profile do
  let(:profile) { build :profile }
  subject { profile }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_and_belong_to_many(:categories) }
    it { is_expected.to have_many(:portfolio_items) }
    it { is_expected.to have_many(:certificates) }
  end
end
