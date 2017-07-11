# == Schema Information
#
# Table name: profiles
#
#  id                          :integer          not null, primary key
#  user_id                     :integer          not null
#  work_type                   :string
#  have_car                    :boolean
#  about                       :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  price_type                  :string
#  price_hourly                :integer
#  price_project               :integer
#  have_instrument             :boolean          default(FALSE)
#  can_departure               :boolean          default(FALSE)
#  working_all_time            :boolean          default(FALSE)
#  working_days                :string
#  working_hours_from          :integer
#  working_hours_to            :integer
#  rating_votes_count          :integer
#  rating_votes_sum            :integer
#  rating                      :float
#  notifications_email_enabled :boolean          default(TRUE)
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
