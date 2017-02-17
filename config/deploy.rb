lock '3.7.2'

set :application, 'delorub'

set :scm, :git
set :repo_url, 'git@github.com:Delorub/delorub.git'

set :rvm_type, :system
set :rvm_ruby_version, "#{File.read('.ruby-version').strip}@#{fetch :stage}"

set :migration_role, :app
set :keep_releases, 5

append :linked_files, 'config/database.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :unicorn_options, { unicorn_stage: fetch(:stage) }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
