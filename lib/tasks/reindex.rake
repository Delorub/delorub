namespace :es do
  desc 'Index all models'
  task reindex: :environment do
    Place.reindex
    Category.reindex
    User.reindex
    Task.reindex
  end
end
