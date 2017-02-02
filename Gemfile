ruby '2.3.1'
source 'http://rubygems.org'

# Main
gem 'rails', '~> 4.2.0'
gem 'mysql2', '~> 0.3.18'
gem 'sidekiq'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 2.0'
gem 'rake', '11.3.0'
gem 'haml'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'rmagick', require: false
gem 'mini_magick'
gem 'therubyracer'
gem 'searchkick'

# Rails core extensions
gem 'cells'
gem 'draper'
gem 'configatron'
gem 'virtus'

# Activerecord extensions
gem 'squeel'
gem 'awesome_nested_set'
gem 'enumerize'
gem 'state_machine'

# Authorization, roles
gem 'devise'
gem 'devise_lastseenable'
gem 'pundit'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-mailru'
gem 'omniauth-gplus'

# Admin
gem 'activeadmin', github: 'activeadmin'
gem 'activeadmin_addons'

# Attachments
gem 'carrierwave', '~> 1.0'

# API
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'hashie-forbidden_attributes'

# Assets
gem 'bower-rails', '~> 0.11.0'
gem 'haml-rails', '~> 0.8'

# Misc
gem 'russian', '~> 0.6.0'
gem 'kaminari'
gem 'translit'

# CHECK
gem 'petrovich', '~> 1.0'
gem 'simple_captcha2', require: 'simple_captcha'
gem 'ipgeobase', git: 'https://github.com/mokevnin/ipgeobase'
gem 'meta-tags', require: 'meta_tags'

group :development do
  gem 'annotate', require: false
  gem 'rubocop', require: false
  gem 'ruby_parser', require: false
  gem 'capistrano-deploy', '~> 0.1.1', require: nil
end

group :development, :test do
  gem 'pry-byebug', require: false
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :development do
  gem 'capistrano'
  gem 'rvm-capistrano', require: false
end

group :production do
  gem 'unicorn'
end