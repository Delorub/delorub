ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!

RSpec.configure do |config|
  # Ensure that if we are running js tests, we are using latest webpack assets
  # This will use the defaults of :js and :server_rendering meta tags
  ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)

  config.include Rails.application.routes.url_helpers

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

if ENV['CIRCLE_ARTIFACTS']
  SimpleCov.coverage_dir "#{ENV['CIRCLE_ARTIFACTS']}/coverage"
end

SimpleCov.start do
  add_group 'API', 'app/api'
  add_group 'Admin', [
    'app/admin',
    'app/controllers/concerns/active_admin_shared',
    'app/helpers/active_admin',
    'app/renderers/active_admin'
  ]
  add_group 'Concerns', 'app/concerns'
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Decorators', 'app/draper_decorators'
  add_group 'Jobs', 'app/jobs'
  add_group 'Searchers', ['app/searchers', 'app/queries']
  add_group 'Renderers', ['app/renderers', 'app/cells', 'app/service_objects', 'app/forms']
  add_group 'Mailers', 'app/mailers'
  add_group 'Lib', 'app/lib'
end
