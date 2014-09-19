class DocumentUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader


  # def store_dir
  #   "documents/#{model.uuid}"
  # end
  
  def will_include_content_type
    true
  end
  
  default_content_type  'application/pdf'
  allowed_content_types %w(application/pdf)

end
