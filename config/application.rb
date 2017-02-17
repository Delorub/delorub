require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Delorub
  class Application < Rails::Application
    config.paths.add 'app/api', glob: '**/*.rb'

    config.i18n.default_locale = :ru
    config.encoding = 'utf-8'

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.active_record.raise_in_transactional_callbacks = true
  end
end
