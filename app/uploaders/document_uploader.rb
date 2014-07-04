# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog


  def store_dir
    "documents/#{model.uuid}"
  end

  def extension_white_list
    %w(pdf)
  end

  # def filename
  #   "something.jpg" if original_filename
  # end

end
