class User::BillingLog < ActiveRecord::Base
  PACK_TYPES = %w(Billing::Task::Pack Billing::Reply::Pack).freeze
  SUBSCRIPTION_TYPES = %w(Billing::Task::Subscription Billing::Reply::Subscription).freeze
  TRANSFER_TYPES = %w(Billing::Transfer::Manually).freeze
  OTHER_TYPES = %w(Billing::Transfer::Blog Billing::Transfer::Color Billing::Transfer::Autorefresh).freeze
  
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
      if user.balance + sum < 0
        errors.add :sum, I18n.t('activerecord.errors.models.company.attributes.new_expert_ids.should_be_members')
      end
    end
end
