ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'shoulda/matchers'
require 'support/controller_helpers'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!(allow_localhost: true)

WebMock \
  .stub_request(:get, 'https://smsc.ru/sys/send.php')
  .with(query: WebMock.hash_including('fmt': '3'))
  .to_return(
    status: 200,
    body: {
      'id': '1',
      'cnt': '1'
    }.to_json
  )

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
  config.raise_javascript_errors = true
end

RSpec.configure do |config|
  config.include Capybara::Vue::DSL

  # Ensure that if we are running js tests, we are using latest webpack assets
  # This will use the defaults of :js and :server_rendering meta tags
  config.filter_run_excluding search: true

  Capybara.javascript_driver = :webkit

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

  config.before(:suite) do
    Place.reindex
    Category.reindex
    Task.reindex
    Searchkick.disable_callbacks
  end

  config.around(:each, search: true) do |example|
    Searchkick.enable_callbacks
    example.run
    Searchkick.disable_callbacks
  end

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end
