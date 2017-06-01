Welcome to the Delorub!

# Getting started

## Install dependencies

For mac OS:

    # automatic
    brew install bundle

    # for sidekiq
    brew install redis

    # for nodejs (need to install npm)
    brew install nodejs

    # npm
    curl -L https://www.npmjs.org/install.sh | sh
    
    # imagemagick
    brew install imagemagick (if you've got an error with installing rmagick, try brew install imagemagick@6 && brew link imagemagick@6 --force)

## Setup application

    # run bundler
    bundle
    
    # run npm
    npm install
    
    # run redis server
    redis-server in terminal

    # configure database
    copy database.yml.sample and rename it to database.yml, change credentials to yours
    
    # run 
    rake db:create
    rake db:migrate
    rake db:seed
    
    # start application
    rails s
