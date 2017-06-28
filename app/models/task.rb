# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string           not null
#  category_id        :integer          not null
#  user_id            :integer          not null
#  price_type         :string           not null
#  price_scale        :string
#  price_exact        :integer
#  price_from         :integer
#  price_to           :integer
#  place_id           :integer
#  place_lat          :float
#  place_long         :float
#  place_address      :string
#  date_type          :string           not null
#  contract_type      :string
#  description        :text
#  notify_email       :boolean
#  visible            :boolean          default(TRUE)
#  archive            :boolean
#  colored            :boolean          default(FALSE)
#  billable_type      :string
#  billable_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  date_actual        :datetime
#  date_interval_from :datetime
#  date_interval_to   :datetime
#

class Task < ApplicationRecord
  include Searchable::Task

  extend Enumerize

  belongs_to :user
  belongs_to :category
  belongs_to :billable, polymorphic: true
  belongs_to :place

  has_many :files, class_name: 'TaskFile', dependent: :destroy
  has_many :replies, dependent: :destroy

  enumerize :price_type, in: [:exact, :interval, :scale]
  enumerize :date_type, in: [:actual, :interval, :none]
  enumerize :contract_type, in: [:no_contract, :contract]

  validates :title, :description, :user_id, :category_id, :price_type, :date_type, presence: true
  validate :ensure_user_can_create

  scope :by_user, ->(user) { where user_id: user.id }
  scope :by_category, ->(category) { where category_id: category.id }
  scope :by_category_with_descendants, ->(category) { where category_id: category.self_and_descendants_ids }
  scope :by_category_ids, ->(category_ids) { where category_id: category_ids }

  after_create :increment_user_free_tasks, unless: :billable
  after_destroy :decrement_user_free_tasks, unless: :billable

  private

    def increment_user_free_tasks
      user.increment :free_tasks_published
      user.save
    end

    def decrement_user_free_tasks
      user.decrement :free_tasks_published
      user.save
    end

    def ensure_user_can_create
      return unless new_record?
      return unless user
      return if user.tasks_available_sum.positive?
      errors.add :user, :no_available_tasks
    end
end
