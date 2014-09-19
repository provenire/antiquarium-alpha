# encoding: utf-8

class WebsiteUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "websites/#{model.uuid}"
  end

end
