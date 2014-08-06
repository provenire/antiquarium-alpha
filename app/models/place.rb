class Place < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - name
  #  - description
  #  - location
  
  
  
  # Concerns
  include UUID
  include Filterable
  
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  has_many :employments
  has_many :places, through: :employments
  
  has_many :interactions, as: :actor
  has_many :events, through: :interactions
  has_many :artifacts, -> { uniq }, through: :events
  
  has_one  :location, as: :locatable
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description]
  
  
  
  # Revisions
  has_paper_trail
  
  
  
  # Scopes
  def self.has_artifacts(yes)
    joins(:events).uniq.joins(:artifacts)
  end
  
  def self.has_photos(yes)
    includes(:photos).where.not(photos: {id: nil})
  end
  
  def self.has_location(yes)
    joins(:location)
  end
  
  def self.has_employments(yes)
    includes(:employments).where.not(employments: {id: nil})
  end
  
  
  
  # Helper functions
  def num_photos
    return self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def next_photos
    self.photos[1..3]
  end
  
  def has_photos?
    self.photos.size > 0
  end
  #alias_method :has_photos, :has_photos?
  
  def has_employments?
    self.employments.size > 0
  end
  alias_method :has_employments, :has_employments?
  
  def has_artifacts?
    self.artifacts.size > 0
  end
  alias_method :has_artifacts, :has_artifacts?
  
end
