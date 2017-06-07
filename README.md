Welcome to the Delorub!

# Getting started

## Setup
### Bundler
To install and run bundler:

```
gem install bundler
bundle
```

If you've got an error with installing rmagick, try `brew install imagemagick@6 && brew link imagemagick@6 --force`

### Frontend
To install packages:
```
brew install nodejs
brew install yarn
curl -L https://www.npmjs.org/install.sh | sh
yarn install
```
    
### Redis
To install and run redis server(for sidekiq):
```
brew install redis
redis-server
```

### Database and import
Copy `database.yml.sample` and rename it to `database.yml`, change credentials to yours

Run `rake db:setup`

Run `rake places:import:seed` for import a dump
    
### Start an application
`foreman start`

### ElasticSearch
`Place.reindex` for reindexing an ES index
