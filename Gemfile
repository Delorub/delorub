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
gem 'figaro'
gem 'render_anywhere'
gem 'inherited_resources'
gem 'wicked'
gem 'reform-rails'

# Activerecord extensions
gem 'squeel'
gem 'awesome_nested_set'
gem 'enumerize'
gem 'state_machine'
gem 'acts_as_list'

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
gem 'activeadmin', '1.0.0.pre4'
gem 'activeadmin_addons'
gem 'activeadmin_reorderable', github: 'delphist/activeadmin_reorderable', branch: 'feature/add-belongs-to-support'
gem 'active_admin-sortable_tree'
gem 'flattened_active_admin'

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
gem 'uglifier'
gem 'yui-compressor'
gem 'haml-rails', '~> 0.8'
gem 'react_on_rails', '~> 6'
gem 'mini_racer', platforms: :ruby
gem 'jquery-ui-rails', '~> 5'

# Misc
gem 'russian', '~> 0.6.0'
gem 'phony_rails'
gem 'kaminari', '~> 0.15'
gem 'translit'
gem 'nokogiri'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'foreman'

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
