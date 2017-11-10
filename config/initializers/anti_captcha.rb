AntiCaptcha.configure do |config|
  config.key = Figaro.env.anti_captcha_api_key
end
