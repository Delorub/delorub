namespace :places do
  namespace :import do
    desc 'Import places data from CSV for development'
    task seed: :environment do
      PlaceImportService.new(seed_development: true).perform
    end
  end

  desc 'Import all places data from CSV'
  task import: :environment do
    PlaceImportService.new.perform
  end
end
