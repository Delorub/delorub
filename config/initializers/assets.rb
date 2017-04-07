Rails.application.config.assets.tap do |assets|
  assets.version = '1.0'
  assets.precompile += %w(admin.css website-bundle.css)
  assets.precompile += %w(admin.js website-bundle.js)
  assets.precompile += %w(.svg .eot .woff .ttf)
  assets.paths << Rails.root.join('app', 'assets', 'webpack')
end
