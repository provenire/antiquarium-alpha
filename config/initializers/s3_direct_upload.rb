S3DirectUpload.config do |c|
  c.access_key_id     = Settings.aws.access_key_id
  c.secret_access_key = Settings.aws.secret_access_key
  c.bucket = Settings.aws.directory
  c.region = Settings.aws.region
  c.url = nil                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end