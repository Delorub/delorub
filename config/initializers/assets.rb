Rails.application.config.assets.tap do |assets|
  assets.version = '1.0'
  assets.precompile += %w[admin.css website-bundle.css website_apps-bundle.css]
  assets.precompile += %w[admin.js website-bundle.js website_apps-bundle.js contract_app-bundle.js ] # contract_designer_app-bundle.js
  assets.precompile += %w[.svg .eot .woff .ttf]
  assets.paths << Rails.root.join('app', 'assets', 'webpack')
  assets.paths << Rails.root.join('app', 'assets', 'fonts')
end
