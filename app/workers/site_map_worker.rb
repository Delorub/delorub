require 'rake'
Delorub::Application.load_tasks

class SiteMapWorker
  include Sidekiq::Worker

  def perform
    Rake::Task['sitemap:refresh:no_ping'].invoke
  end
end
