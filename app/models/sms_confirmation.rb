# == Schema Information
#
# Table name: sms_confirmations
#
#  id           :integer          not null, primary key
#  token        :string
#  phone        :string
#  code         :string
#  accepted     :boolean          default(FALSE)
#  attempts     :integer          default(0)
#  last_sent_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SmsConfirmation < ApplicationRecord
  validates :phone, :code, :token, presence: true

  before_validation :generate_code
  after_save :send_sms

  def check_code value
    raise Exception, 'SMS is not send to generate token' if new_record?
    if value == code
      generate_token
      true
    else
      increment :attempts
      false
    end
  end

  def token
    super || generate_token
  end

  def resend_code
    generate_code
    send_sms
  end

  private

    def generate_token
      self.token = Digest::MD5.hexdigest "#{id}_#{code}"
    end

    def send_sms
      self.last_sent_at = Time.zone.now
      SmsSender.new(
        phone: phone,
        message: I18n.t('user_sms_confirmation', code: code)
      ).perform
    end

    def generate_code
      self.code = [1, 1, 1, 1].map! { |x| (0..9).to_a.sample }.join
    end
end
