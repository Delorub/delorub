namespace :load do
  task :defaults do
    set :parser_pid, -> { File.join(shared_path, 'tmp', 'pids', 'parser.rb.pid') }
    set :parser_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
    set :parser_role, -> { :app }

    set :rbenv_map_bins, fetch(:rbenv_map_bins).to_a.concat(%w[bin/parser])
    set :rvm_map_bins, fetch(:rvm_map_bins).to_a.concat(%w[bin/parser])
    set :chruby_map_bins, fetch(:chruby_map_bins).to_a.concat(%w[bin/parser])
  end
end

namespace :deploy do
  after 'deploy:starting', 'parser:stop'
  after 'deploy:published', 'parser:start'
end

# rubocop:disable Metrics/BlockLength
namespace :parser do
  def start_parser
    within release_path do
      execute :bundle, :exec, 'bin/parser', 'start', "-- --environment=#{fetch(:parser_env)}"
    end
  end

  def stop_parser
    within release_path do
      begin
        execute :bundle, :exec, 'bin/parser', 'stop', "-- --environment=#{fetch(:parser_env)}"
      rescue SSHKit::Command::Failed
        warn 'parser is not running (ignore if this is the first deploy)'
      end
    end
  end

  task :start do
    on roles fetch(:parser_role) do |role|
      switch_user(role) do
        start_parser
      end
    end
  end

  task :stop do
    on roles fetch(:parser_role) do |role|
      switch_user(role) do
        stop_parser
      end
    end
  end
end
