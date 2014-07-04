class ThumbnailUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process :convert => 'jpg'
  process :tags => ['antiquarium']
end
