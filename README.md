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

    #  Also needs to install npm and bower (it's only manual)
    curl -L https://www.npmjs.org/install.sh | sh
    npm install -g bower

## Setup application

    # run bundler
    bundle

    # start application
    rails s
