module SignedInAs
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in_as_master?
  end

  private

    def signed_in_as_master?
      return false if session[:signed_in_as].nil?
      session[:signed_in_as].to_sym == :master
    end
end
