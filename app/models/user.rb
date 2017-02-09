class User < ActiveRecord::Base
  FREE_TASKS = 3
  FREE_REPLIES = 3

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  include Searchable::User
  include Geotaggable
  
  has_many :billing_logs
  has_many :tasks, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :permission, class_name: "UserPermission", dependent: :destroy

  has_many :task_packs, class_name: "Billing::TaskPack", dependent: :destroy
  has_many :task_subscriptions, class_name: "Billing::TaskSubscription", dependent: :destroy
  has_many :reply_packs, class_name: "Billing::ReplyPack", dependent: :destroy
  has_many :reply_subscriptions, class_name: "Billing::ReplySubscription", dependent: :destroy

  has_one :active_task_subscription, -> { active }, class_name: "Billing::TaskSubscription"
  has_one :active_reply_subscription, -> { active }, class_name: "Billing::ReplySubscription"
  has_one :active_task_pack, -> { active }, class_name: "Billing::TaskSubscription"
  has_one :active_reply_pack, -> { active }, class_name: "Billing::ReplySubscription"
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: "password.nil?"
  validates :password, presence: true, if: "id.nil?"
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  
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
    super || self.build_permission
  end

  private

    def check_free_replies_and_tasks
      free_tasks_published = [free_tasks_published.to_i, FREE_TASKS].min
      free_replies_published = [free_replies_published.to_i, FREE_TASKS].min
    end
end
