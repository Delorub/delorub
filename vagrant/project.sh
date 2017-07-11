# database setup
sudo su - postgres -c 'createuser -s dr'

# rails
su - vagrant -c 'rvm install 2.3.1'
su - vagrant -c 'gem install bundler'
su - vagrant -c 'cd /vagrant && bundle install'
su - vagrant -c 'cd /vagrant && bundle install'
su - vagrant -c 'cd /vagrant && bundle exec rake db:setup'
su - vagrant -c 'cd /vagrant && bundle exec rake db:seed'

# client
su - vagrant -c 'cd /vagrant/client && yarn install'
