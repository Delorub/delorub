# == Schema Information
#
# Table name: help_questions
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  content    :text
#  reply      :text
#  answered   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  replied_at :datetime
#

class HelpQuestion < ApplicationRecord
  validates :name, :email, :content, presence: true
  validates :content, length: { minimum: 8 }

  before_save :check_reply
  after_save :send_reply, if: :reply_changed?

  def send_reply
    HelpQuestionsMailer.reply(self).deliver
  end

  def display_name
    "##{id}"
  end

  private

    def check_reply
      return if reply == '' || !reply_changed?
      self.replied_at = Time.current
      self.answered = true
    end
end
