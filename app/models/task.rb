# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  category_id   :integer          not null
#  user_id       :integer          not null
#  price_type    :string           not null
#  price_scale   :string(255)
#  price_exact   :integer
#  price_from    :integer
#  price_to      :integer
#  place_id      :integer
#  place_lat     :float(24)
#  place_long    :float(24)
#  place_address :string(255)
#  date_type     :string           not null
#  date_actual   :integer
#  date_from     :datetime
#  date_to       :datetime
#  contract_type :string(255)
#  description   :text(65535)
#  notify_email  :boolean
#  visible       :boolean          default(TRUE)
#  archive       :boolean
#  colored       :boolean          default(FALSE)
#  billable_type :string(255)
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Task < ActiveRecord::Base
  include Searchable::Task

  extend Enumerize

  belongs_to :user
  belongs_to :category
  belongs_to :billable, polymorphic: true

  enumerize :price_type, in: [:exact, :interval, :scale]
  enumerize :date_type, in: [:actual, :interval]
  enumerize :contract_type, in: [:no_contract, :contract]

  validates :title, :description, :user, :category, :price_type, :date_type, presence: true
  validate :ensure_user_can_create

  after_create :update_user

  private

    def ensure_user_can_create
      return unless !new_record? && user && user.can_post_task?
      errors.add(:user, 'cannot create tasks')
    end

    def update_user; end
end
