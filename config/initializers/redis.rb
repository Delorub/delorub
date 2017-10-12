require 'redis'

Redis.current = Redis.new Rails.application.config_for(:redis)

Redis.current.flushdb if Rails.env.test?
