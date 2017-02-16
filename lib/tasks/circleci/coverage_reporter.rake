namespace :circleci do
  desc 'Report total coverage from all test runs in all containers'
  task :coverage do
    require 'circle_ci/coverage_reporter'
    CircleCi::CoverageReporter.report_coverage
  end
end
