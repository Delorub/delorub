module UserHelper
  def profile_or_user_path user
    return profile_path(user.profile) if user.master?
    ''
  end

  def online_status status
    return '<span class="status-online">Online</span>'.html_safe if status
  end
end
