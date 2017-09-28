# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Load RVM
require 'capistrano/rvm'

# Load Yarn
require 'capistrano/yarn'

# Load Rails
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Slack
require 'slackistrano/capistrano'
require_relative 'lib/slackistrano/custom_messaging'

# Load Puma
require 'capistrano/puma'
install_plugin Capistrano::Puma

# Load whenever
require 'whenever/capistrano'

# Load sidekiq
require 'capistrano/sidekiq'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
