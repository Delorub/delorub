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
#  colored            :boolean          default(FALSE)
#  billable_type      :string
#  billable_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  date_actual        :datetime
#  date_interval_from :datetime
#  date_interval_to   :datetime
#  aasm_state         :string
#
# Indexes
#
#  index_tasks_on_aasm_state  (aasm_state)
#

class Task < ApplicationRecord
  include AASM
  include Searchable::Task
  extend Enumerize

  belongs_to :user
  belongs_to :category
  belongs_to :billable, polymorphic: true
  belongs_to :place

  has_many :files, class_name: 'TaskFile', dependent: :destroy
  has_many :replies, dependent: :destroy

  has_and_belongs_to_many :subcategories,
    class_name: 'Category',
    association_foreign_key: 'subcategory_id',
    join_table: 'subcategories_tasks'

  has_one :deal
  has_one :accepted_reply, -> { accepted }, class_name: 'Reply'

  enumerize :price_type, in: [:exact, :interval, :scale]
  enumerize :date_type, in: [:end_at, :start_at, :interval]
  enumerize :contract_type, in: [:no_contract, :contract]

  validates :title, :description, :user_id, :category_id, :price_type, :date_type, presence: true

  scope :by_user, ->(user) { where user_id: user.id }
  scope :by_category, ->(category) { where category_id: category.id }
  scope :by_category_with_descendants, ->(category) { where category_id: category.self_and_descendants_ids }
  scope :by_category_ids, ->(category_ids) { where category_id: category_ids }

  aasm initial: :moderation do
    state :moderation, :rejected, :active, :in_deal, :archived

    event :reject do
      transitions from: :moderation, to: :rejected
    end

    event :accept do
      transitions from: :moderation, to: :active
    end

    event :make_deal do
      transitions from: :active, to: :in_deal
    end

    event :archive do
      transitions from: :active, to: :archive
    end
  end
end
