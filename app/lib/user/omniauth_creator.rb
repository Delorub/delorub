class User::OmniauthCreator
  attr_reader :omniauth, :user

  def initialize omniauth
    @omniauth = omniauth
    @user = nil
    @password = nil
  end

  def perform
    return user if check_user_with_same_email
    create_new_user
  end

  def password
    @password ||= Devise.friendly_token[0, 20]
  end

  private

    def create_new_user
      @user = User.new
      assign_email
      assign_attributes
      assign_photo
      add_omniauth_relation
      return false unless user.save
      user
    end

    def check_user_with_same_email
      @user = User.find_by(email: fetch_email)
      return if @user.nil?
      add_omniauth_relation
      user.save
      user
    end

    def add_omniauth_relation
      user.omniauth_relations << omniauth
    end

    def assign_email
      @user.email = fetch_email
    end

    def fetch_email
      case omniauth.provider.to_sym
      when :odnoklassniki
        omniauth.data.dig(:extra, :raw_info, :email)
      else
        omniauth.data.info.email
      end
    end

    def assign_attributes
      @user.first_name = omniauth.data.info.first_name.strip
      @user.last_name = omniauth.data.info.last_name.strip
      @user.password = password
    end

    def assign_photo
      case omniauth.provider.to_sym
      when :odnoklassniki
        [:pic_3, :pic_2, :pic_1].each do |param|
          try_image = omniauth.data.dig(:extra, :raw_info, param)
          next if try_image.nil?
          @user.remote_photo_url = try_image
          break if @user.photo.present?
        end
      else
        @user.remote_photo_url = omniauth.data.info.image
      end
    rescue CarrierWave::DownloadError => e
      Rails.logger.error e.message
    end
end
