require 'optparse'

@options = { environment: 'development' }
OptionParser.new do |opts|
  opts.on('-e NAME', '--environment=NAME', 'Rails environment') do |e|
    @options[:environment] = e
  end
end.parse!
ENV['RAILS_ENV'] = @options[:environment]

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exist?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, 'config', 'environment')

i = 0

# TODO: rubocop:disable Metrics/BlockLength
loop do
  ActiveRecord::Base.connection.clear_query_cache
  categories = Category.all.reload.select { |e| e.external_data_settings.words.present? }
  accounts = ExternalData::VkAccount.active.all

  if categories.count.zero? || accounts.count.zero?
    puts 'No category or account, sleeping'
    sleep 60
    next
  end

  parser = ExternalData::Parser::Vkapi::Newsfeed.new(accounts.last)
  max = categories.size
  i = 0 if i >= max
  category = categories[i]
  if category.nil?
    puts 'No category, sleeping'
    sleep 60

    next
  end

  category.external_data_settings.words.each do |word|
    puts "Processing #{word}"

    parser.perform(word, category)

    sleep 60
  end

  i += 1
end
