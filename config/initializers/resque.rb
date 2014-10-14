require 'resque-sliders'

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user     == ENV["RESQUE_WEB_HTTP_BASIC_AUTH_USER"]
  password == ENV["RESQUE_WEB_HTTP_BASIC_AUTH_PASSWORD"]
end

if ENV["REDISCLOUD_URL"]
  Resque.redis = Redis.new(url: ENV["REDISCLOUD_URL"])
else
  Resque.redis = 'localhost:6379'
end