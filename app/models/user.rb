# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  middle_name            :string
#  phone                  :string
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
#  access_token           :string
#  place_id               :integer
#  first_name             :string
#  last_name              :string
#  delocoin_balance       :decimal(10, 2)   default(0.0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_place_id              (place_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  FREE_TASKS = 5
  FREE_REPLIES = 3

  phony_normalize :phone
  phony_normalized_method :phone

  include Searchable::User
  include Geotaggable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  belongs_to :place

  has_many :omniauth_relations, dependent: :nullify

  has_many :billing_logs, dependent: :destroy
  has_many :billing_yandex_kassa_deposits, through: :billing_logs, source: :billable, source_type: 'Billing::YandexKassa::Deposit'

  has_many :tasks, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :permission, class_name: 'UserPermission', dependent: :destroy
  has_one :profile, class_name: '::Profile', dependent: :destroy
  has_many :portfolios, through: :profile

  accepts_nested_attributes_for :permission

  validates :first_name, :email, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :phone, phony_plausible: true

  scope :by_phone, ->(phone) { where(phone: PhonyRails.normalize_number(phone)) }

  has_secure_token :access_token

  mount_uploader :photo, UserPhotoUploader

  def master?
    profile.present? && !profile.new_record?
  end

  def permission
    super || build_permission
  end
end
