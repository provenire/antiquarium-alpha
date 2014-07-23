if ENV["REDISCLOUD_URL"]
  Resque.redis = Redis.new(url: ENV["REDISCLOUD_URL"])
end