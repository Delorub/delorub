class UserDecorator < Draper::Decorator
  decorates User
  delegate_all

  def name
    "#{first_name} #{last_name}".strip
  end
end
