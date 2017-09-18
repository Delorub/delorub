require 'rake'
Delorub::Application.load_tasks

class SiteMapWorker
  include Sidekiq::Worker

  def perform
    if Rails.env.production?
      Rake::Task['sitemap:refresh'].invoke
    else
      Rake::Task['sitemap:refresh:no_ping'].invoke
    end
  end
end
