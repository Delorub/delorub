require 'simplecov'
require 'json'

module CircleCi
  class CoverageReporter
    COVERAGE_RESULTS_DIR = '/tmp/coverage-data'.freeze

    class << self
      def report_coverage
        copy_results_from_other_containers
        report merged_results
      end

      def copy_results_from_other_containers
        FileUtils.mkdir_p COVERAGE_RESULTS_DIR

        threads = Array.new total_containers do |index|
          Thread.new index do |container|
            puts "Copying coverage results from container #{container}"
            `scp ubuntu@node#{container}:/home/ubuntu/#{reponame}/coverage/.resultset-\*-\*.json #{results_dir}`
          end
        end

        threads.each(&:join)
      end

      def reponame
        ENV['CIRCLE_PROJECT_REPONAME']
      end

      def total_containers
        ENV['CIRCLE_NODE_TOTAL'].to_i
      end

      def results_dir
        COVERAGE_RESULTS_DIR
      end

      def all_results
        Dir["#{results_dir}/.resultset-*-*.json"]
      end

      def merged_results
        merged_all_results = all_results.inject({}) do |results, result_file_name|
          puts "Processing #{result_file_name}"
          json_data = JSON.parse File.read(result_file_name)
          json_data.reduce results do |merged, (name, data)|
            SimpleCov::Result.from_hash(name => data).original_result.merge_resultset merged
          end
        end

        SimpleCov::Result.new(merged_all_results).tap do |mergedset|
          mergedset.command_name = 'RSpec and Cucumber'
        end
      end

      # rubocop:disable Metrics/MethodLength
      def report results
        SimpleCov.configure do
          coverage_dir "#{ENV['CIRCLE_ARTIFACTS']}/coverage"

          add_group 'API', 'app/api'
          add_group 'Admin', [
            'app/admin',
            'app/controllers/concerns/active_admin_shared',
            'app/helpers/active_admin',
            'app/renderers/active_admin'
          ]
          add_group 'Concerns', 'app/concerns'
          add_group 'Models', 'app/models'
          add_group 'Controllers', 'app/controllers'
          add_group 'Helpers', 'app/helpers'
          add_group 'Decorators', 'app/draper_decorators'
          add_group 'Jobs', 'app/jobs'
          add_group 'Searchers', ['app/searchers', 'app/queries']
          add_group 'Renderers', ['app/renderers', 'app/cells', 'app/service_objects', 'app/forms']
          add_group 'Mailers', 'app/mailers'
          add_group 'Lib', 'app/lib'
        end

        SimpleCov::Formatter::HTMLFormatter.new.format results
      end
    end
  end
end
