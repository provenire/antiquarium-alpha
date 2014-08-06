class Artifact < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - alternate_names
  #  - description
  #  - artist
  #  - dimensions
  #  - date_created
  
  
  
  # Concerns
  include UUID
  include Filterable
  
  
  
  # Relations
  has_and_belongs_to_many :photos
  has_and_belongs_to_many :events
  
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :alternate_names, :description, :artist]
  
  
  # Revisions
  has_paper_trail
  
  
  
  # Scopes
  def self.has_events(yes)
    joins(:events).uniq
  end
  
  def self.has_photos(yes)
    includes(:photos).where.not(photos: {id: nil})
  end
  
  def self.has_artist(yes)
    where.not(artist: '')
  end
  
  def self.has_dimensions(yes)
    where.not(dimensions: '')
  end
  
  def self.has_date_created(yes)
    where.not(date_created: '')
  end
  
  
  
  # Helpers
  def names
    self.alternate_names || []
  end
  
  def materials_comma_separated
    self.materials.pluck(:name).join(", ")
  end
  
  def has_events?
    self.events.size > 0
  end
  
  def num_photos
    return self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def next_photos
    self.photos[1..3]
  end
  
  def current_status
    self.events.order(:date).last || nil
  end
  
end
