class Source < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - name
  #  - description
  #  - status
  #  - thumbnail
  #  - document
  
  
  # Concerns
  include UUID
  include Filterable
  
  
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
  
  
  # Helpers
  def has_photos?
    self.thumbnail.url.nil?
  end
  
  def default_photo_uploader
    self.thumbnail
  end
  
  
  # Scopes
  def self.websites(yes)
    where(type: 'Website')
  end
  
  def self.books(yes)
    where(type: 'Book')
  end
  
  def self.documents(yes)
    where(type: 'Document')
  end
  
  def self.has_events(yes)
    joins(:citations).joins(:events).uniq
  end
  
end
