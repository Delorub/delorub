class UserDecorator < Draper::Decorator
  decorates User
  decorates_association :profile
  delegate_all

  def name
    "#{first_name} #{last_name}".strip
  end

  def formatted_name
    "#{first_name} #{last_name.present? ? format('%s.', last_name[0]) : ''}".strip
  end

  def online?
    User::OnlineService.new(self).online?
  end

  def login_credentials_text
    [phone, email].compact.join(' или ')
  end
end
