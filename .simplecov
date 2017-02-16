if ENV['COVERAGE'] == 'true'
  require 'simplecov'

  SimpleCov.start 'rails' do
    if ENV['CIRCLE_NODE_INDEX']
      SimpleCov.at_exit do
        SimpleCov.result.format! # creates coverage/.resultset.json
        # Copy the results to a name which is unique across all containers and retries
        FileUtils.cp 'coverage/.resultset.json', "coverage/.resultset-#{ENV['CIRCLE_NODE_INDEX']}-#{Time.now.to_i}.json"
      end
    end

    add_filter '/boxes/'
    add_filter '/data/'
    add_filter '/doc/'
    add_filter "/#{ENV['CIRCLE_PROJECT_REPONAME']}/lib/"
    add_filter '/public/'
    add_filter '/script/'
    add_filter '/solr/'
    add_filter '/vendor/'
  end
end
