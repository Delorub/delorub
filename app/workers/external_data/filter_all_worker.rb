class ExternalData::FilterAllWorker
  include Sidekiq::Worker

  def perform
    ExternalData::FilterAll.new.perform
  end
end
