Extractor.configure do |config|
  config.key        = Settings.embedly.key
  config.user_agent = Settings.embedly.user_agent
end

AlchemyAPI.key = "26683d4dd2cc364527f284942d0a4cb43586a8a0"