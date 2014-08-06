class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog


  def store_dir
    "documents/#{model.uuid}"
  end

end
