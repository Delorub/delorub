namespace :vk do
  namespace :test do
    desc 'VK newsfeed test'
    task newsfeed: :environment do
      ExternalData.delete_all
      ExternalData::Parser::Vkapi::Newsfeed.new('нужен сантехник').perform
    end
  end
end
