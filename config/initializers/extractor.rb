Extractor.configure do |config|
  config.key        = Settings.embedly.key
  config.user_agent = Settings.embedly.user_agent
end