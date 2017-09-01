class UserDecorator < Draper::Decorator
  decorates User
  decorates_association :profile
  delegate_all

  def name
    "#{first_name} #{last_name}".strip
  end

  def online?
    User::OnlineService.new(self).online?
  end
end
