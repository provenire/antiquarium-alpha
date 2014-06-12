CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJQBHPNNCLCEENDWA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'antiquarium' # required
end