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
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            source_id:   Proc.new{|controller, model| model.id},
            name:        Proc.new{|controller, model| model.name},
            description: Proc.new{|controller, model| model.description},
            thumb:       Proc.new{|controller, model| model.thumbnail.small.url}
          }
  
  
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
