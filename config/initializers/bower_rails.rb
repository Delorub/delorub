BowerRails.configure do |bower_rails|
  # Invokes rake bower:install before precompilation. Defaults to false
  bower_rails.install_before_precompile = true

  # Invokes rake bower:resolve before precompilation. Defaults to false
  bower_rails.resolve_before_precompile = true

  # Invokes rake bower:clean before precompilation. Defaults to false
  bower_rails.clean_before_precompile = true

  # Invokes rake bower:install:deployment instead of rake bower:install. Defaults to false
  bower_rails.use_bower_install_deployment = true
end
