class Notification < ActiveRecord::Base
  serialize :params, JSON

  belongs_to :user, counter_cache: true
  belongs_to :notifiable, polymorphic: true
  
  validates :user, presence: true
  validates :notifiable, presence: true, unless: :notifiable_optional?
  validate :ensure_user_not_deleted, if: :user

  scope :unread,               -> { where(state: :delivered).where{ notifications.read_at == nil } }
  scope :unviewed,             -> { where{ notifications.viewed_at == nil } }
  scope :last_week,            -> { where { date(created_at).in (1.week.ago.to_date..1.day.ago.to_date) } }
  scope :yesterday,            -> { where { date(created_at) == 1.day.ago.to_date } }
  scope :latest,               -> { order{ created_at.desc } }
  scope :delivered,            -> { where(state: :delivered) }
  scope :expired, -> (time = Time.now, period = 3.months) do
    where{ (created_at <= time - period)  }
  end
  
  after_destroy :update_user_unread_notifications_count, if: :unread?

  state_machine initial: :created do
    state :created
    state :delivered

    event :deliver do
      transition created: :delivered
    end

    after_transition on: :deliver, do: [:update_user_unread_notifications_count, :update_cache_unviewed_notifications_count]
  end
  
  def notifiable_optional?
    false
  end

  def mark_as_read
    transaction do
      update_attributes read_at: Time.now
      user.cache_unread_notifications_count
    end
  end
  
  def self.read_all
    update_all read_at: Time.now
  end
  
  def unread?
    not read_at
  end
  
  def update_user_unread_notifications_count
    user.cache_unread_notifications_count
  end

  def update_cache_unviewed_notifications_count
    cache_unviewed_notifications_count
  end
  
  def ensure_user_not_deleted
    errors.add :user, 'is deleted' if user.deleted?
  end
end
