class User < ActiveRecord::Base
  FREE_TASKS = 3
  FREE_REPLIES = 3

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  include Searchable::User
  include Geotaggable
  
  has_many :billing_logs
  has_many :tasks, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :billing_task_packs, class_name: "Billing::TaskPack", dependent: :destroy
  has_many :billing_task_subscriptions, class_name: "Billing::TaskSubscription", dependent: :destroy
  has_many :billing_reply_packs, class_name: "Billing::ReplyPack", dependent: :destroy
  has_many :billing_reply_subscriptions, class_name: "Billing::ReplySubscription", dependent: :destroy
  has_one :permission, class_name: "UserPermission", dependent: :destroy
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: "password.nil?"
  validates :password, presence: true, if: "id.nil?"
  
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  
  mount_uploader :photo, UserPhotoUploader
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def reply_packs_available_sum
    billing_reply_packs.sum(:amount) - billing_reply_packs.sum(:spent)
  end
  
  def task_packs_available_sum
    billing_task_packs.sum(:amount) - billing_task_packs.sum(:spent)
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
end
