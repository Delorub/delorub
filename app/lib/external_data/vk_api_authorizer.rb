require 'capybara/poltergeist'

class ExternalData::VkApiAuthorizer
  attr_reader :login, :password

  def initialize login:, password:
    @login = login
    @password = password
  end

  def perform
    authorize
    confirm_application_if_needed
    access_token
  end

  private

    def access_token
      VkontakteApi.app_id = app_id
      VkontakteApi.app_secret = app_secret
      VkontakteApi.redirect_uri = redirect_uri
      VkontakteApi.authorize(code: code_from_redirect_uri).token
    end

    def code_from_redirect_uri
      callback_request = browser.driver.network_traffic.detect do |request|
        redirect_uri_regexp.match? request.url
      end

      raise 'Cannot process to callback uri' if callback_request.nil?

      uri = URI(callback_request.url)
      params = CGI.parse(uri.query)

      params['code'].first
    end

    def authorize
      browser.visit authorize_url

      attempt = 0
      loop do
        attempt += 1
        raise 'Maximum attempts of login used' if attempt > 3

        browser.fill_in 'email', with: login
        browser.fill_in 'pass', with: password
        browser.find('button[type=submit]').click

        break unless check_and_solve_captcha_if_exists('.oauth_captcha', 'captcha_key')
      end

      raise 'Invalid account credentials' if browser.has_css? '.box_error'
    end

    def check_and_solve_captcha_if_exists captcha, input
      return unless browser.has_css? captcha
      captcha_src = browser.find(captcha)[:src]

      @client = AntiCaptcha::Client.new(retries_count: 10, phrase: 1)
      code = @client.decode(HTTParty.get(captcha_src))

      browser.fill_in input, with: code
    end

    def confirm_application_if_needed
      browser.find('button[type=submit]').click
    rescue
      nil
    end

    def browser
      @_browser ||= new_session
    end

    def new_session
      Capybara.configure do |config|
        config.run_server = false
      end

      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(
          app,
          js_errors: false,
          timeout: 180,
          phantomjs_options: ['--load-images=false']
        )
      end

      Capybara::Session.new(:poltergeist)
    end

    def redirect_uri_regexp
      @_redirect_uri_regexp ||= Regexp.new('^' + Regexp.escape(redirect_uri), Regexp::IGNORECASE)
    end

    def app_id
      '6064911'
    end

    def app_secret
      'sAEQC27d4tC9PatXo86F'
    end

    def redirect_uri
      'http://local.delorub.ru/users/auth/vkontakte/callback'
    end

    def authorize_url
      'https://oauth.vk.com/authorize?client_id=' + app_id + '&scope=' + vk_scope + '&redirect_uri=' + redirect_uri
    end

    def vk_scope
      'offline'
    end
end
