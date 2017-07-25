module RedirectComingSoon
  extend ActiveSupport::Concern

  included do
    before_action :check_and_redirect_coming_soon
  end

  protected

    def check_and_redirect_coming_soon
      return if self.class.parent.in? [Admin, Editor]
      return if controller_name.in? %w[main coming_soon_sessions pages sessions]
      redirect_to new_coming_soon_session_path
    end
end
