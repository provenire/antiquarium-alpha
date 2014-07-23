# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  
  process :convert => 'jpg'
  process :tags => ['antiquarium']
  
  version :object_single do
    process :eager => true
    cloudinary_transformation :width => 360, :height => 240, :crop => :fill, :gravity => :face
  end
  
  version :object_main do
    process :eager => true
    cloudinary_transformation :width => 255, :height => 245, :crop => :fill, :gravity => :face
  end

  version :object_thumb do
    process :eager => true
    cloudinary_transformation :width => 95, :height => 95, :crop => :thumb, :gravity => :face
  end
  
  version :show do
    process :eager => true
    cloudinary_transformation :width => 765, :crop => :lpad
  end
  
  version :event_thumb do
    process :eager => true
    cloudinary_transformation :width => 50, :height => 50, :crop => :thumb, :gravity => :face
  end
  
  version :small_thumb do
    process :eager => true
    cloudinary_transformation :width => 35, :height => 35, :crop => :thumb, :gravity => :face
  end
  
  version :thumb do
    process :eager => true
    cloudinary_transformation :width => 400, :height => 300, :crop => :thumb, :gravity => :face
  end

end
