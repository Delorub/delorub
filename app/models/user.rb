# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  middle_name            :string
#  last_name              :string
#  phone                  :string
#  skype                  :string
#  website                :string
#  birthday               :date
#  profile_id             :integer
#  free_tasks_published   :integer          default(0), not null
#  free_replies_published :integer          default(0), not null
#  balance                :decimal(10, 2)   default(0.0), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  photo                  :string
#  phone_confirmed        :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  FREE_TASKS = 3
  FREE_REPLIES = 3

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  phony_normalize :phone
  phony_normalized_method :phone

  include Searchable::User
  include Geotaggable

  has_many :omniauth_relations, dependent: :nullify

  has_many :billing_logs, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :permission, class_name: 'UserPermission', dependent: :destroy
  has_one :profile

  has_many :task_packs, class_name: 'Billing::TaskPack', dependent: :destroy
  has_many :task_subscriptions, class_name: 'Billing::TaskSubscription', dependent: :destroy
  has_many :reply_packs, class_name: 'Billing::ReplyPack', dependent: :destroy
  has_many :reply_subscriptions, class_name: 'Billing::ReplySubscription', dependent: :destroy

  has_one :active_task_subscription, -> { active }, class_name: 'Billing::TaskSubscription'
  has_one :active_reply_subscription, -> { active }, class_name: 'Billing::ReplySubscription'
  has_one :active_task_pack, -> { active }, class_name: 'Billing::TaskSubscription'
  has_one :active_reply_pack, -> { active }, class_name: 'Billing::ReplySubscription'

  accepts_nested_attributes_for :permission

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: 'password.nil?'
  validates :password, presence: true, if: 'id.nil?'
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :phone, phony_plausible: true
  validate :ensure_phone_not_confirmed, if: :phone

  scope :confirmed_phone, ->(n) { where{ (phone == n) & (phone_confirmed == true) } }

  before_save :check_free_replies_and_tasks

  mount_uploader :photo, UserPhotoUploader

  def name
    "#{first_name} #{last_name}"
  end

  def reply_packs_available_sum
    reply_packs.sum(:amount) - reply_packs.sum(:spent)
  end

  def task_packs_available_sum
    task_packs.sum(:amount) - task_packs.sum(:spent)
  end

  def free_tasks_available_sum
    FREE_TASKS - free_tasks_published
  end

  def free_replies_available_sum
    FREE_REPLIES - free_replies_published
  end

  def tasks_available_sum
    task_packs_available_sum + free_tasks_available_sum
  end

  def replies_available_sum
    reply_packs_available_sum + free_replies_available_sum
  end

  def permission
    super || build_permission
  end

  private

    def check_free_replies_and_tasks
      self.free_tasks_published = [free_tasks_published.to_i, FREE_TASKS].min
      self.free_replies_published = [free_replies_published.to_i, FREE_TASKS].min
    end

    def ensure_phone_not_confirmed
      return if User.confirmed_phone(normalized_phone).where{ id != my{ id } }.empty?
      errors.add :phone, :uniqueness
    end
end
