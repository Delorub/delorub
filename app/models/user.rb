class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: "password.nil?"
  validates :password, presence: true, if: "id.nil?"
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def available_answers
    paid_answers + 3
  end
  
  def paid_answers
    0
  end
  
  def available_tasks
    paid_tasks + 3
  end
  
  def paid_tasks
    0
  end
end
