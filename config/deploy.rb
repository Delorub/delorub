lock '3.8.2'

set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :application, 'delorub'
set :repo_url, 'git@github.com:Delorub/delorub.git'

set :rvm_type, :system
set :rvm_ruby_version, "#{File.read('.ruby-version').strip}@#{fetch :stage}"

set :migration_role, :app
set :keep_releases, 5

append :linked_files, 'config/database.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'

set :slackistrano,
  klass: Slackistrano::CustomMessaging,
  channel: '#deploy',
  webhook: 'https://hooks.slack.com/services/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'

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_environment, fetch(:stage)

set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_env, fetch(:stage)
set :pty, false
