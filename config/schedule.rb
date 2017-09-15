set :output, error: 'log/whenever_error.log', standard: 'log/whenever.log'

every 1.day, at: '5:00 am' do
  case @environment
    when 'production'
      rake 'sitemap:refresh'
    else
      rake 'sitemap:refresh:no_ping'
  end
end
