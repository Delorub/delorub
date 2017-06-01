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

### Npm
To install npm packages:
```
brew install nodejs
curl -L https://www.npmjs.org/install.sh | sh
npm install
```
    
### Redis
To install and run redis server(for sidekiq):
```
brew install redis
redis-server
```

### Database
Copy `database.yml.sample` and rename it to `database.yml`, change credentials to yours

Run `rake db:setup`
    
### Start an application
`rails s`
