# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  task_id       :integer
#  user_id       :integer
#  status        :string
#  content       :text
#  billable_type :string
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  aasm_state    :string
#
# Indexes
#
#  index_replies_on_aasm_state  (aasm_state)
#

class Reply < ApplicationRecord
  include AASM
  include Searchable::Reply

  belongs_to :task
  belongs_to :user
  belongs_to :billable, polymorphic: true

  validates :user, :task, :content, presence: true
  validates :content, length: { minimum: 5, maximum: 2000 }

  scope :by_user, ->(user) { where user_id: user.id }

  aasm initial: :none do
    state :none, initial: true
    state :declined, :accepted

    event :cancel_decline do
      transitions from: :declined, to: :none
    end

    event :decline do
      transitions from: :none, to: :declined
    end

    event :accept do
      transitions from: :none, to: :accepted, guard: :no_other_accepted_replies
    end
  end

  private

    def no_other_accepted_replies
      return if task.blank?
      task.replies.accepted.count.zero?
    end
end
