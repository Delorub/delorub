ruby '2.3.1'
source 'http://rubygems.org'

# Main
gem 'rails', '~> 4.2.0'
gem 'mysql2', '~> 0.3.18'
gem 'sidekiq'
gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 2.0'
gem 'rake', '11.3.0'
gem 'haml'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'rmagick', require: false
gem 'mini_magick'
gem 'searchkick'
gem 'rabl'
gem 'oj'

# Rails core extensions
gem 'cells'
gem 'draper'
gem 'configatron'
gem 'virtus'
gem 'figaro'
gem 'render_anywhere'

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
gem 'httparty'

# Assets
gem 'uglifier', '>= 1.3.0'
gem 'yui-compressor'
gem 'haml-rails', '~> 0.8'
gem 'react_on_rails', '~> 6'
gem 'mini_racer', platforms: :ruby

# Misc
gem 'russian', '~> 0.6.0'
gem 'phony_rails'
gem 'kaminari'
gem 'translit'
gem 'nokogiri'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# CHECK
gem 'petrovich', '~> 1.0'
gem 'simple_captcha2', require: 'simple_captcha'
gem 'ipgeobase', git: 'https://github.com/mokevnin/ipgeobase'
gem 'meta-tags', require: 'meta_tags'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-byebug', require: false
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'spring'
end

group :development do
  gem 'annotate'
  gem 'rubocop', require: false
  gem 'rubocop-rspec-focused', require: false
  gem 'ruby_parser', require: false
  gem 'capistrano', '~> 3.7'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'capistrano3-unicorn'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'rspec-its'
  gem 'rspec-rails', require: false
  gem 'simplecov', require: false
  gem 'webmock'
end

group :production do
  gem 'unicorn'
end
