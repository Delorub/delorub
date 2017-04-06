namespace :assets do
  desc "Compile assets with webpack"
  task :webpack do
    sh "cd client && yarn install"
  end
end
