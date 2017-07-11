# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  first_name             :string
#  middle_name            :string
#  last_name              :string
#  phone                  :string
#  skype                  :string
#  website                :string
#  email                  :string
#  birthday               :date
#  profile_id             :integer
#  free_tasks_published   :integer          default(0), not null
#  free_replies_published :integer          default(0), not null
#  balance                :decimal(10, 2)   default(0.0), not null
#  photo                  :string
#  phone_confirmed        :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  access_token           :string
#  place_id               :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_place_id              (place_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

describe User do
  let(:user) { build :user }
  subject { user }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(4) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:omniauth_relations) }
    it { is_expected.to have_many(:billing_logs) }
    it { is_expected.to have_many(:tasks) }
    it { is_expected.to have_many(:replies) }
    it { is_expected.to have_many(:task_packs) }
    it { is_expected.to have_many(:task_subscriptions) }
    it { is_expected.to have_many(:reply_packs) }
    it { is_expected.to have_many(:reply_subscriptions) }
    it { is_expected.to have_one(:permission) }
    it { is_expected.to have_one(:profile) }
    it { is_expected.to have_one(:active_task_subscription) }
    it { is_expected.to have_one(:active_reply_subscription) }
    it { is_expected.to have_one(:active_task_pack) }
    it { is_expected.to have_one(:active_reply_pack) }
    it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end

  describe 'phone' do
    context 'when phone number not entered' do
      let!(:another_user) { create :user }
      before do
        user.phone = nil
        user.phone_confirmed = false
      end

      it { is_expected.to be_valid }
    end

    context 'when someone confirmed same phone number' do
      let!(:another_user) { create :user }
      before do
        user.phone = another_user.phone
        user.phone_confirmed = false
      end

      it { is_expected.not_to be_valid }
    end

    context 'when someone have same unconfirmed phone number' do
      let!(:another_user) { create :user, phone_confirmed: false }
      before do
        user.phone = another_user.phone
        user.phone_confirmed = false
      end

      it { is_expected.to be_valid }
    end

    context 'when someone confirmed same phone number in different format' do
      let!(:another_user) { create :user, phone: '+7 999 123 33 22', phone_confirmed: true }
      before do
        user.phone = '7(999)1233322'
        user.phone_confirmed = false
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe 'callbacks' do
    let(:user) { create :user }
    context 'access token generation' do
      it 'checks that access token exists after user has been created' do
        expect(user.access_token).not_to be_nil
      end
    end
  end
end
