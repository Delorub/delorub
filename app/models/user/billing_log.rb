# == Schema Information
#
# Table name: user_billing_logs
#
#  id            :integer          not null, primary key
#  sum           :float
#  user_id       :integer
#  billable_type :string
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User::BillingLog < ApplicationRecord
  PACK_TYPES = %w[Billing::TaskPack Billing::ReplyPack].freeze
  SUBSCRIPTION_TYPES = %w[Billing::TaskSubscription Billing::ReplySubscription].freeze
  TRANSFER_TYPES = %w[Billing::TransferManually].freeze
  OTHER_TYPES = %w[Billing::TransferBlog Billing::TransferColor Billing::TransferAutorefresh].freeze

  belongs_to :user
  belongs_to :billable, polymorphic: true

  validate :user_have_enough_balance

  after_save :update_user_amount

  scope :latest, -> { order{ created_at.desc } }
  scope :packs, -> { where{ billable_type.in PACK_TYPES } }
  scope :subscriptions, -> { where{ billable_type.in SUBSCRIPTION_TYPES } }

  private

    def update_user_amount
      user.increment(:balance, sum)
      user.save!
    end

    def user_have_enough_balance
      errors.add :sum, I18n.t('activerecord.errors.user_balance') if (user.balance + sum).negative?
    end
end
