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
  
  
  # Relationships
  has_many :citations
  has_many :events, through: :citations
  has_many :artifacts, -> { uniq }, through: :events
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description]
  
  
  # Revisions
  has_paper_trail
  
end
