require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Delorub
  class Application < Rails::Application
    config.paths.add 'app/api', glob: '**/*.rb'

    additional_paths = %W(
      #{config.root}/app/models/concerns
      #{config.root}/app/controllers/concerns
      #{config.root}/app/value_objects
    )
    config.autoload_paths   += additional_paths
    config.eager_load_paths += additional_paths

    config.i18n.default_locale = :ru
    config.encoding = 'utf-8'

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.active_record.raise_in_transactional_callbacks = true
  end
end
