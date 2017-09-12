require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Delorub
  class Application < Rails::Application
    config.paths.add 'app/api', glob: '**/*.rb'

    additional_paths = %W[
      #{config.root}/app/models/concerns
      #{config.root}/app/controllers/concerns
      #{config.root}/app/lib
      #{config.root}/app/validators
      #{config.root}/app/services
    ]
    config.autoload_paths += additional_paths
    config.eager_load_paths += additional_paths

    config.i18n.default_locale = :ru
    config.encoding = 'utf-8'

    config.time_zone = 'Europe/Moscow'
    config.active_record.default_timezone = :local

    config.before_initialize do |app|
      app.config.paths.add 'app/services', eager_load: true
      app.config.paths.add 'app/value_objects', eager_load: true
    end

    config.to_prepare do
      Dir[File.expand_path(Rails.root.join('app', 'value_objects', '**', '*.rb'))].each do |file|
        require_dependency file
      end
    end
  end
end
