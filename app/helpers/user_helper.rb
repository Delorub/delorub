module UserHelper
  def profile_or_user_path user
    return profile_path(user.profile) if user.master?
    ''
  end
end
