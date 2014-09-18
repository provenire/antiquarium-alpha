class ThumbnailUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process :convert => 'jpg'
  process :tags => ['antiquarium']
  
  
  version :small do
    process :eager => true
    cloudinary_transformation :width => 35, :height => 35, :crop => :fill
  end
end
