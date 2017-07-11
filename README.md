# Delorub

Welcome to the Delorub!

# Getting started

## Recommended setup (vagrant)

### Vagrant & Virtualbox
First, install vagrant and virtualbox:
https://www.vagrantup.com/
https://www.virtualbox.org/

### Run the box

Run these commands to setup a new box and install the application
`vagrant up`

## Running the project

First, login to the vagrant box:
`vagrant ssh`

Then, navigate to the project folder:
`cd /vagrant`

And run foreman:
`foreman start`

And now you can open http://localhost:5000/ in your local browser

## Running project manually

Now you need to start the rails server:
`rails s -b 0.0.0.0`
Note: it's important to run webserver on 0.0.0.0

Also you need to start webpack (you can run several ssh sessions or use `screen` for this):
`yarn run build:dev:client`

## Common problems and questions

### ElasticSearch

Reindeing all models:

`rake searchkick:reindex:all`
