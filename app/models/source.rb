class Source < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - name
  #  - description
  #  - status
  #  - thumbnail
  #  - document
  
  
  # UUID
  include UUID
  
  
  # Mount Carrierwave
  mount_uploader :document,  DocumentUploader
  mount_uploader :thumbnail, ThumbnailUploader
  
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description]
  
  
end
